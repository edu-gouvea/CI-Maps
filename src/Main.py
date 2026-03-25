import tkinter as tk
from tkinter import messagebox, ttk
import os
from pyswip import Prolog


# ─────────────────────────────────────────────
#  PALETA DE CORES
# ─────────────────────────────────────────────
C = {
    "bg":          "#F4F5F7",   # fundo geral (cinza muito claro)
    "surface":     "#FFFFFF",   # cards / superfícies
    "border":      "#E0E0E0",   # bordas sutis
    "primary":     "#1A237E",   # azul UFPB
    "primary_hov": "#303F9F",   # azul hover
    "primary_lt":  "#E8EAF6",   # azul clarinho (badges)
    "text":        "#212121",   # texto principal
    "text2":       "#757575",   # texto secundário
    "success":     "#2E7D32",   # verde (direto)
    "success_lt":  "#E8F5E9",   # verde claro (badge)
    "danger":      "#C62828",   # vermelho (destino dot)
    "white":       "#FFFFFF",
}

# ─────────────────────────────────────────────
#  HELPERS
# ─────────────────────────────────────────────

def card_frame(parent, pady_inner=16, padx_inner=20):
    """Frame com visual de card (fundo branco + borda de 1px)."""
    outer = tk.Frame(parent, bg=C["border"], bd=0)
    inner = tk.Frame(outer, bg=C["surface"], bd=0)
    inner.pack(padx=1, pady=1, fill="both", expand=True)
    content = tk.Frame(inner, bg=C["surface"], padx=padx_inner, pady=pady_inner)
    content.pack(fill="both", expand=True)
    return outer, content


def section_label(parent, text):
    tk.Label(
        parent, text=text.upper(),
        font=("Helvetica", 9, "bold"),
        bg=C["surface"], fg=C["text2"],
        anchor="w",
    ).pack(anchor="w", pady=(0, 10))


# ─────────────────────────────────────────────
#  CLASSE PRINCIPAL
# ─────────────────────────────────────────────

class CIMapsGUI:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("CI Maps — GPS Universitário")
        self.root.geometry("760x700")
        self.root.configure(bg=C["bg"])
        self.root.resizable(False, False)

        self.prolog = Prolog()
        try:
            self.prolog.consult("src/regras.pl")
        except Exception as e:
            messagebox.showerror("Erro", f"Erro ao carregar Prolog: {e}")

        self._build_styles()
        self._build_ui()

    # ── Estilos ttk ──────────────────────────
    def _build_styles(self):
        s = ttk.Style()
        try:
            s.theme_use("clam")
        except Exception:
            pass

        s.configure(
            "CI.TCombobox",
            fieldbackground=C["surface"],
            background=C["surface"],
            foreground=C["text"],
            arrowcolor=C["text2"],
            bordercolor=C["border"],
            lightcolor=C["border"],
            darkcolor=C["border"],
            font=("Helvetica", 13),
        )
        s.map(
            "CI.TCombobox",
            fieldbackground=[
                ("readonly focus", C["surface"]),
                ("readonly !focus", C["surface"]),
                ("readonly", C["surface"]),
            ],
            foreground=[
                ("readonly focus", C["text"]),
                ("readonly !focus", C["text"]),
                ("readonly", C["text"]),
            ],
            background=[
                ("readonly focus", C["surface"]),
                ("readonly !focus", C["surface"]),
                ("readonly", C["surface"]),
            ],
            selectbackground=[("readonly", C["primary"])],
            selectforeground=[("readonly", C["white"])],
        )

        s.configure(
            "CI.TButton",
            font=("Helvetica", 12, "bold"),
            foreground=C["white"],
            background=C["primary"],
            borderwidth=0,
            focusthickness=0,
            padding=(20, 10),
        )
        s.map(
            "CI.TButton",
            background=[("active", C["primary_hov"]), ("pressed", "#0D1B6E")],
        )

    # ── Layout principal ──────────────────────
    def _build_ui(self):
        main = tk.Frame(self.root, bg=C["bg"], padx=28, pady=24)
        main.pack(fill="both", expand=True)
        self._build_header(main)
        self._build_search_card(main)
        self._build_results_card(main)

    # ── Header ────────────────────────────────
    def _build_header(self, parent):
        outer, row = card_frame(parent, pady_inner=16, padx_inner=20)
        outer.pack(fill="x", pady=(0, 14))

        # Logo — imagem CI
        logo_box = tk.Frame(row, bg=C["surface"], width=52, height=52)
        logo_box.pack(side="left")
        logo_box.pack_propagate(False)
        try:
            logo_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "ci_logo.png")
            self._logo_img = tk.PhotoImage(file=logo_path)
            tk.Label(
                logo_box, image=self._logo_img,
                bg=C["surface"], borderwidth=0,
            ).place(relx=0.5, rely=0.5, anchor="center")
        except Exception:
            tk.Label(
                logo_box, text="🗺", font=("Helvetica", 22),
                bg=C["surface"],
            ).place(relx=0.5, rely=0.5, anchor="center")

        # Textos
        txt = tk.Frame(row, bg=C["surface"])
        txt.pack(side="left", padx=14)
        tk.Label(
            txt, text="CI Maps",
            font=("Helvetica", 17, "bold"),
            bg=C["surface"], fg=C["primary"],
        ).pack(anchor="w")
        tk.Label(
            txt, text="GPS Universitário · Centro de Informática",
            font=("Helvetica", 11),
            bg=C["surface"], fg=C["text2"],
        ).pack(anchor="w")

        # Badge
        tk.Label(
            row, text="  UFPB  ",
            font=("Helvetica", 10, "bold"),
            bg=C["primary_lt"], fg=C["primary"],
            padx=8, pady=4,
        ).pack(side="right")

    # ── Card de busca ─────────────────────────
    def _build_search_card(self, parent):
        outer, inner = card_frame(parent)
        outer.pack(fill="x", pady=(0, 14))

        section_label(inner, "Planejar viagem")

        row = tk.Frame(inner, bg=C["surface"])
        row.pack(fill="x")

        tk.Label(
            row, text="Origem:",
            font=("Helvetica", 12),
            bg=C["surface"], fg=C["text"],
        ).pack(side="left", padx=(0, 10))

        try:
            raw = list(self.prolog.query("ponto_da_linha(Ponto, _)"))
            pontos = sorted(set(
                p["Ponto"] for p in raw
                if "Terminal Quadramares" not in p["Ponto"]
            ))
        except Exception:
            pontos = []
        self.combo = ttk.Combobox(
            row, values=pontos, style="CI.TCombobox",
            state="readonly", width=36, font=("Helvetica", 13),
        )
        self.combo.pack(side="left", padx=(0, 12))
        self.combo.set("Selecione a origem...")

        ttk.Button(
            row, text="Ver rotas", style="CI.TButton",
            command=self._buscar,
        ).pack(side="left")

    # ── Card de resultados ────────────────────
    def _build_results_card(self, parent):
        outer, inner = card_frame(parent, pady_inner=20)
        outer.pack(fill="both", expand=True)

        # Badge destino
        dest_row = tk.Frame(inner, bg=C["primary_lt"], padx=12, pady=8)
        dest_row.pack(fill="x", pady=(0, 16))
        tk.Label(
            dest_row, text="●", font=("Helvetica", 10),
            bg=C["primary_lt"], fg=C["danger"],
        ).pack(side="left")
        tk.Label(
            dest_row,
            text="  Destino:  CI — Terminal Quadramares, UFPB",
            font=("Helvetica", 11),
            bg=C["primary_lt"], fg=C["text"],
        ).pack(side="left")

        # Área com scroll
        wrap = tk.Frame(inner, bg=C["surface"])
        wrap.pack(fill="both", expand=True)

        self.canvas = tk.Canvas(wrap, bg=C["surface"], highlightthickness=0, bd=0)
        vsb = ttk.Scrollbar(wrap, orient="vertical", command=self.canvas.yview)
        self.canvas.configure(yscrollcommand=vsb.set)

        vsb.pack(side="right", fill="y")
        self.canvas.pack(side="left", fill="both", expand=True)

        self.scroll_frame = tk.Frame(self.canvas, bg=C["surface"])
        self._win_id = self.canvas.create_window(
            (0, 0), window=self.scroll_frame, anchor="nw"
        )

        self.scroll_frame.bind("<Configure>", self._on_frame_configure)
        self.canvas.bind("<Configure>", self._on_canvas_configure)

        # Scroll — bind direto no canvas e no scroll_frame
        self._bind_scroll_widget(self.canvas)
        self._bind_scroll_widget(self.scroll_frame)

        self._show_empty_state()

    def _bind_scroll_widget(self, widget):
        """Registra scroll no widget e em todos os filhos recursivamente."""
        widget.bind("<MouseWheel>", self._on_mousewheel, add="+")
        widget.bind("<Button-4>",   self._on_mousewheel, add="+")
        widget.bind("<Button-5>",   self._on_mousewheel, add="+")
        for child in widget.winfo_children():
            self._bind_scroll_widget(child)

    def _on_frame_configure(self, _e):
        self.canvas.configure(scrollregion=self.canvas.bbox("all"))

    def _on_canvas_configure(self, e):
        self.canvas.itemconfig(self._win_id, width=e.width)

    def _on_mousewheel(self, e):
        if e.num == 4:          # Linux scroll up
            self.canvas.yview_scroll(-1, "units")
        elif e.num == 5:        # Linux scroll down
            self.canvas.yview_scroll(1, "units")
        else:                   # Windows / macOS
            self.canvas.yview_scroll(int(-1 * (e.delta / 120)), "units")

    # ── Estado vazio ──────────────────────────
    def _show_empty_state(self):
        for w in self.scroll_frame.winfo_children():
            w.destroy()
        tk.Label(
            self.scroll_frame,
            text="Selecione uma origem para ver as rotas disponíveis.",
            font=("Helvetica", 12),
            bg=C["surface"], fg=C["text2"],
            pady=40,
        ).pack()

    # ── Busca ─────────────────────────────────
    def _buscar(self):
        origem = self.combo.get()
        if not origem or "Selecione" in origem:
            return
        self._render_results(origem)

    def _render_results(self, origem: str):
        for w in self.scroll_frame.winfo_children():
            w.destroy()

        dados = self._query_prolog(origem)
        diretas    = dados.get("diretas", [])
        baldeacoes = dados.get("baldeacoes", [])

        if not diretas and not baldeacoes:
            tk.Label(
                self.scroll_frame,
                text="Nenhuma rota encontrada para esta origem.",
                font=("Helvetica", 12),
                bg=C["surface"], fg=C["text2"],
                pady=30,
            ).pack()
            return

        if diretas:
            self._section_head("🚌  Linhas diretas", C["success"], C["success_lt"])
            for r in diretas:
                self._card_direta(r["num"], r["nome"])
            if baldeacoes:
                self._divider()

        if baldeacoes:
            self._section_head("🔄  Com baldeação", C["primary"], C["primary_lt"])
            for b in baldeacoes:
                self._card_baldeacao(b["l1"], b["ponto"], b["l2"])

    def _query_prolog(self, origem: str) -> dict:
        try:
            diretas_raw = list(self.prolog.query(f"rota_direta('{origem}', Linha)"))
            diretas = []
            for r in diretas_raw:
                info = list(self.prolog.query(f"nome_linha('{r['Linha']}', Nome)"))
                nome = info[0]["Nome"] if info else ""
                diretas.append({"num": r["Linha"], "nome": nome})
            bald = list(self.prolog.query(f"rota_com_baldeacao('{origem}', L1, PB, L2)"))
            baldeacoes = [{"l1": b["L1"], "ponto": b["PB"], "l2": b["L2"]} for b in bald]
            return {"diretas": diretas, "baldeacoes": baldeacoes}
        except Exception as e:
            messagebox.showerror("Erro Prolog", str(e))
            return {"diretas": [], "baldeacoes": []}

    # ── Componentes de resultado ──────────────
    def _section_head(self, text: str, fg: str, bg: str):
        row = tk.Frame(self.scroll_frame, bg=C["surface"], pady=4)
        row.pack(fill="x", padx=4, pady=(4, 6))
        tk.Label(
            row, text=f"  {text}  ",
            font=("Helvetica", 11, "bold"),
            bg=bg, fg=fg, padx=8, pady=5,
        ).pack(side="left")

    def _card_direta(self, num: str, nome: str):
        frame = tk.Frame(self.scroll_frame, bg=C["bg"], padx=16, pady=12)
        frame.pack(fill="x", padx=4, pady=(0, 8))

        left = tk.Frame(frame, bg=C["bg"])
        left.pack(side="left", fill="x", expand=True)

        tk.Label(
            left, text=f"Linha {num}",
            font=("Helvetica", 18, "bold"),
            bg=C["bg"], fg=C["primary"],
        ).pack(anchor="w")
        tk.Label(
            left, text=nome,
            font=("Helvetica", 11),
            bg=C["bg"], fg=C["text2"],
            wraplength=440, justify="left",
        ).pack(anchor="w")

        tk.Label(
            frame, text="  Direto  ",
            font=("Helvetica", 10, "bold"),
            bg=C["success_lt"], fg=C["success"],
            padx=8, pady=4,
        ).pack(side="right", anchor="n")

    def _card_baldeacao(self, l1: str, ponto: str, l2: str):
        frame = tk.Frame(self.scroll_frame, bg=C["bg"], padx=16, pady=12)
        frame.pack(fill="x", padx=4, pady=(0, 8))

        def col(label_top, value, mono=False):
            f = tk.Frame(frame, bg=C["bg"])
            f.pack(side="left")
            tk.Label(f, text=label_top, font=("Helvetica", 9),
                     bg=C["bg"], fg=C["text2"]).pack(anchor="center")
            fnt = ("Courier", 16, "bold") if mono else ("Helvetica", 11)
            tk.Label(f, text=value, font=fnt,
                     bg=C["bg"], fg=C["text"]).pack(anchor="center")

        def arrow():
            tk.Label(
                frame, text=" → ",
                font=("Helvetica", 16),
                bg=C["bg"], fg=C["text2"],
                pady=10,
            ).pack(side="left")

        col("Pegue", l1, mono=True)
        arrow()
        col("Troque em", ponto)
        arrow()
        col("Pegue", l2, mono=True)

    def _divider(self):
        tk.Frame(self.scroll_frame, bg=C["border"], height=1).pack(
            fill="x", padx=4, pady=10
        )


# ─────────────────────────────────────────────
#  ENTRY POINT
# ─────────────────────────────────────────────
if __name__ == "__main__":
    root = tk.Tk()
    root.lift()
    root.attributes("-topmost", True)
    root.after_idle(root.attributes, "-topmost", False)
    CIMapsGUI(root)
    root.mainloop()