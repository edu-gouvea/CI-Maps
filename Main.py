import tkinter as tk
from tkinter import ttk, messagebox
import os
import unicodedata
from pyswip import Prolog

# ──────────────────────────────────────────────
#  Paleta UFPB — azul institucional + neutros
# ──────────────────────────────────────────────
C = {
    "bg":          "#EDEEF2",   # fundo geral
    "surface":     "#FFFFFF",   # cards
    "surface2":    "#F5F6FA",   # fundo secundário
    "primary":     "#1A237E",   # azul UFPB
    "primary_lt":  "#283593",   # azul um pouco mais claro
    "accent":      "#1565C0",   # azul médio
    "accent_lt":   "#E8EAF6",   # azul muito claro (badge)
    "btn":         "#00796B",   # teal — botão buscar
    "btn_hover":   "#00695C",   # teal escuro (hover)
    "success":     "#2E7D32",   # verde (rota direta)
    "success_lt":  "#E8F5E9",
    "warning":     "#E65100",   # laranja (baldeação)
    "warning_lt":  "#FFF3E0",
    "border":      "#D0D3DE",
    "text":        "#1A1C2E",
    "text2":       "#5C6180",
    "text3":       "#9298B0",
    "badge_bus":   "#1A237E",
    "badge_acc":   "#4CAF50",
    "white":       "#FFFFFF",
}

FONT_TITLE  = ("Georgia", 22, "bold")
FONT_HEAD   = ("Helvetica", 13, "bold")
FONT_SUB    = ("Helvetica", 11, "bold")
FONT_BODY   = ("Helvetica", 11)
FONT_SMALL  = ("Helvetica", 9)
FONT_BADGE  = ("Helvetica", 9, "bold")
FONT_MONO   = ("Courier", 10)


# ──────────────────────────────────────────────
#  Widget helpers
# ──────────────────────────────────────────────

def badge(parent, text, bg, fg="#FFFFFF", padx=8, pady=2):
    """Pequena etiqueta arredondada (simulada com tk.Label)."""
    lbl = tk.Label(parent, text=text, bg=bg, fg=fg,
                   font=FONT_BADGE, padx=padx, pady=pady,
                   relief="flat")
    return lbl


def separator(parent, color=None, pady=6):
    color = color or C["border"]
    frm = tk.Frame(parent, bg=color, height=1)
    frm.pack(fill="x", pady=pady)
    return frm


def labeled_row(parent, label, value, fg_label=None, fg_value=None, icon=""):
    """Linha label: valor lado a lado."""
    fg_label = fg_label or C["text2"]
    fg_value = fg_value or C["text"]
    row = tk.Frame(parent, bg=C["surface"])
    row.pack(fill="x", pady=1)
    tk.Label(row, text=f"{icon}  {label}" if icon else label,
             font=FONT_SMALL, fg=fg_label, bg=C["surface"],
             width=14, anchor="w").pack(side="left")
    tk.Label(row, text=value,
             font=FONT_BODY, fg=fg_value, bg=C["surface"],
             anchor="w").pack(side="left", padx=4)
    return row


def formatar_id(id_parada):
    """
    Converte ids internos como p001, p002...
    para o formato visual P01, P02...
    """
    try:
        texto = str(id_parada).strip()
        if texto.lower().startswith("p"):
            num = int(texto[1:])
            return f"P{num:02d}"
        return texto
    except:
        return str(id_parada)


# ──────────────────────────────────────────────
#  Aplicação principal
# ──────────────────────────────────────────────

class CIMapsGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("CI Maps — GPS Universitário · UFPB")
        self.root.configure(bg=C["bg"])
        self.root.attributes("-fullscreen", True)
        self.root.bind("<Escape>", lambda e: self.root.attributes("-fullscreen", False))

        # Prolog
        self.prolog = Prolog()
        try:
            self.prolog.consult("src/regras.pl")
        except Exception as e:
            messagebox.showerror("Erro Prolog", f"Não foi possível carregar a base de conhecimento:\n{e}")

        self._build_ui()

    # ── carrega paradas ───────────────────────
    def _get_paradas(self):
        try:
            raw = list(self.prolog.query("parada(Id, _, Ref, Bairro, _)"))
            self._paradas_map = {
                f"{formatar_id(r['Id'])} - {r['Ref']} ({r['Bairro']})": str(r['Id'])
                for r in raw
            }
            return sorted(self._paradas_map.keys())
        except:
            self._paradas_map = {}
            return []

    def _normalizar(self, texto):
        """Remove acentos e converte para minúsculas (equalsIgnoreCase + sem acento)."""
        return unicodedata.normalize("NFD", texto).encode("ascii", "ignore").decode().lower()

    # ── monta toda a interface ────────────────
    def _build_ui(self):
        # ── Sidebar esquerda ──
        self.sidebar = tk.Frame(self.root, bg=C["primary"], width=260)
        self.sidebar.pack(side="left", fill="y")
        self.sidebar.pack_propagate(False)
        self._build_sidebar()

        # ── Área principal ──
        self.main = tk.Frame(self.root, bg=C["bg"])
        self.main.pack(side="left", fill="both", expand=True)
        self._build_topbar()
        self._build_search_area()
        self._build_results_area()

    # ── Sidebar ───────────────────────────────
    def _build_sidebar(self):
        sb = self.sidebar

        # Logo / título
        top = tk.Frame(sb, bg=C["primary"], pady=30)
        top.pack(fill="x")

        try:
            logo_path = os.path.join(os.path.dirname(__file__), "ci_logo.png")
            self._logo = tk.PhotoImage(file=logo_path).subsample(2, 2)
            tk.Label(top, image=self._logo, bg=C["primary"]).pack()
        except:
            pass

        tk.Label(top, text="CI Maps", font=("Georgia", 20, "bold"),
                 fg=C["white"], bg=C["primary"]).pack(pady=(8, 2))
        tk.Label(top, text="GPS Universitário · UFPB",
                 font=FONT_SMALL, fg="#90A4AE", bg=C["primary"]).pack()

        separator(sb, color="#283593", pady=0)

        # Menu lateral (informativo)
        items = [
            ("🚌", "Rotas Diretas", "Linha vai direto ao CI"),
            ("🔄", "Com Baldeação", "Troca de linha no caminho"),
            ("♿", "Acessibilidade", "Recursos nas paradas"),
            ("🕐", "Horários", "Primeira e última viagem"),
        ]
        info_frame = tk.Frame(sb, bg=C["primary"], pady=10)
        info_frame.pack(fill="x", padx=16)
        tk.Label(info_frame, text="O QUE VOCÊ VÊ",
                 font=FONT_BADGE, fg="#90A4AE", bg=C["primary"]).pack(anchor="w", pady=(10, 6))

        for icon, title, desc in items:
            row = tk.Frame(info_frame, bg=C["primary_lt"], pady=8, padx=10)
            row.pack(fill="x", pady=3)
            tk.Label(row, text=icon, font=("Helvetica", 16),
                     bg=C["primary_lt"], fg=C["white"]).pack(side="left")
            col = tk.Frame(row, bg=C["primary_lt"])
            col.pack(side="left", padx=8)
            tk.Label(col, text=title, font=FONT_BADGE,
                     fg=C["white"], bg=C["primary_lt"]).pack(anchor="w")
            tk.Label(col, text=desc, font=FONT_SMALL,
                     fg="#90A4AE", bg=C["primary_lt"]).pack(anchor="w")

        # Rodapé sidebar
        footer = tk.Frame(sb, bg=C["primary"])
        footer.pack(side="bottom", fill="x", pady=16, padx=16)
        separator(footer, color="#283593")
        tk.Label(footer, text="Pressione ESC para sair\nda tela cheia",
                 font=FONT_SMALL, fg="#90A4AE", bg=C["primary"],
                 justify="center").pack()

    # ── Topbar ────────────────────────────────
    def _build_topbar(self):
        bar = tk.Frame(self.main, bg=C["surface"], height=60)
        bar.pack(fill="x")
        bar.pack_propagate(False)

        tk.Label(bar, text="Centro de Informática — UFPB",
                 font=FONT_HEAD, fg=C["primary"], bg=C["surface"]
                 ).pack(side="left", padx=24, pady=16)

        tk.Label(bar, text="Destino fixo: Terminal Quadramares · LIQ/Mangabeira VII",
                 font=FONT_SMALL, fg=C["text2"], bg=C["surface"]
                 ).pack(side="right", padx=24)

    # ── Área de busca ─────────────────────────
    def _build_search_area(self):
        frm = tk.Frame(self.main, bg=C["bg"], pady=18, padx=24)
        frm.pack(fill="x")

        tk.Label(frm, text="Selecione seu ponto de origem",
                 font=FONT_SUB, fg=C["text"], bg=C["bg"]).pack(anchor="w", pady=(0, 10))

        row = tk.Frame(frm, bg=C["bg"])
        row.pack(fill="x")

        style = ttk.Style()
        style.configure("Custom.TCombobox", padding=6)

        self._todas_paradas = self._get_paradas()

        self.combo = ttk.Combobox(
            row,
            values=self._todas_paradas,
            width=62,
            font=FONT_BODY,
            style="Custom.TCombobox",
            state="readonly"
        )
        self.combo.pack(side="left", ipady=6)
        self.combo.set("Selecione uma parada…")

        # Flag para bloquear scroll dos resultados quando o dropdown estiver aberto
        self._combo_aberto = False
        self.combo.bind("<<ComboboxSelected>>", lambda e: self._set_combo_aberto(False))
        self.combo.bind("<FocusOut>",           lambda e: self._set_combo_aberto(False))
        self.combo.bind("<ButtonPress-1>",      lambda e: self._set_combo_aberto(True))

        self._btn_canvas = self._make_button(
            row, text="  BUSCAR ROTA  →",
            bg=C["primary"], fg=C["white"],
            hover=C["primary_lt"],
            command=self._buscar
        )
        self._btn_canvas.pack(side="left", padx=12)

    def _make_button(self, parent, text, bg, fg, hover, command):
        """Botão desenhado em Canvas — cor garantida em qualquer OS."""
        font = ("Helvetica", 11, "bold")

        tmp = tk.Label(parent, text=text, font=font)
        tmp.update_idletasks()
        w = tmp.winfo_reqwidth() + 32
        h = tmp.winfo_reqheight() + 16
        tmp.destroy()

        cv = tk.Canvas(parent, width=w, height=h,
                       highlightthickness=0, cursor="hand2", bg=parent["bg"])
        rect = cv.create_rectangle(0, 0, w, h, fill=bg, outline=bg)
        cv.create_text(w//2, h//2, text=text, fill=fg,
                       font=font, anchor="center")

        def on_enter(_):
            cv.itemconfig(rect, fill=hover, outline=hover)

        def on_leave(_):
            cv.itemconfig(rect, fill=bg, outline=bg)

        def on_click(_):
            command()

        cv.bind("<Enter>", on_enter)
        cv.bind("<Leave>", on_leave)
        cv.bind("<Button-1>", on_click)
        return cv

    # ── Área de resultados ────────────────────
    def _build_results_area(self):
        wrapper = tk.Frame(self.main, bg=C["bg"])
        wrapper.pack(fill="both", expand=True, padx=24, pady=(0, 24))

        # Canvas + scrollbar
        self.canvas = tk.Canvas(wrapper, bg=C["bg"], highlightthickness=0)
        scrollbar = ttk.Scrollbar(wrapper, orient="vertical", command=self.canvas.yview)
        self.canvas.configure(yscrollcommand=scrollbar.set)

        scrollbar.pack(side="right", fill="y")
        self.canvas.pack(side="left", fill="both", expand=True)

        self.results_frame = tk.Frame(self.canvas, bg=C["bg"])
        self._canvas_window = self.canvas.create_window((0, 0), window=self.results_frame, anchor="nw")

        self.results_frame.bind("<Configure>", self._on_frame_configure)
        self.canvas.bind("<Configure>", self._on_canvas_configure)

        # Scroll permanente — verifica se o mouse está sobre a área de resultados
        self.root.bind_all("<MouseWheel>", self._on_mousewheel)
        self.root.bind_all("<Button-4>", self._on_mousewheel)
        self.root.bind_all("<Button-5>", self._on_mousewheel)
        self._scroll_wrapper = wrapper

        # Placeholder inicial
        self._show_placeholder()

    def _on_frame_configure(self, event):
        self.canvas.configure(scrollregion=self.canvas.bbox("all"))

    def _on_canvas_configure(self, event):
        self.canvas.itemconfig(self._canvas_window, width=event.width)

    def _set_combo_aberto(self, estado):
        self._combo_aberto = estado

    def _on_mousewheel(self, event):
        # Não rola enquanto o dropdown do combo estiver aberto
        if self._combo_aberto:
            return

        # Só rola se o mouse estiver sobre a área de resultados
        wx = self._scroll_wrapper.winfo_rootx()
        wy = self._scroll_wrapper.winfo_rooty()
        ww = self._scroll_wrapper.winfo_width()
        wh = self._scroll_wrapper.winfo_height()
        mx = self.root.winfo_pointerx()
        my = self.root.winfo_pointery()
        if not (wx <= mx <= wx + ww and wy <= my <= wy + wh):
            return

        # Calcula o step
        if event.num == 4:
            step = -1
        elif event.num == 5:
            step = 1
        else:
            delta = event.delta
            if abs(delta) < 30:
                step = -1 if delta > 0 else 1
            else:
                step = int(-1 * (delta / 120))

        # Limites com tolerância para evitar bug visual
        top, bottom = self.canvas.yview()
        if step < 0 and top < 0.001:
            return
        if step > 0 and bottom > 0.999:
            return

        self.canvas.yview_scroll(step, "units")

    def _show_placeholder(self):
        for w in self.results_frame.winfo_children():
            w.destroy()
        ph = tk.Frame(self.results_frame, bg=C["bg"])
        ph.pack(expand=True, pady=60)
        tk.Label(ph, text="🗺️", font=("Helvetica", 48), bg=C["bg"]).pack()
        tk.Label(ph, text="Selecione uma parada e clique em Buscar Rota",
                 font=FONT_BODY, fg=C["text2"], bg=C["bg"]).pack(pady=8)

    # ── Busca ─────────────────────────────────
    def _buscar(self):
        sel = self.combo.get()

        id_parada = self._paradas_map.get(sel)

        if not id_parada:
            messagebox.showwarning("Atenção", "Selecione uma parada válida no menu.")
            return

        # Remove o highlight de seleção do combo e tira o foco dele
        self.combo.selection_clear()
        self.root.focus()

        # Limpa resultados anteriores
        for w in self.results_frame.winfo_children():
            w.destroy()

        try:
            diretas = list(self.prolog.query(f"rota_direta({id_parada}, Linha)"))
            baldeacoes = list(self.prolog.query(f"rota_com_baldeacao({id_parada}, L1, IdB, L2)"))
            recursos_origem = list(self.prolog.query(f"recursos_parada({id_parada}, Recursos)"))

            # Cabeçalho de origem
            self._render_origem_header(id_parada, recursos_origem)

            if not diretas and not baldeacoes:
                self._render_sem_rota()
                return

            if diretas:
                self._render_section_title("🚌  Rotas Diretas", C["success"])
                for r in diretas:
                    self._render_card_direta(r["Linha"])

            if baldeacoes:
                self._render_section_title("🔄  Rotas com Baldeação", C["warning"])
                for b in baldeacoes:
                    self._render_card_baldeacao(b["L1"], b["IdB"], b["L2"])

        except Exception as e:
            lbl = tk.Label(self.results_frame, text=f"Erro na consulta: {e}",
                           fg="red", bg=C["bg"], font=FONT_BODY)
            lbl.pack(pady=20)

        self.canvas.yview_moveto(0)

    # ── Renderizadores ────────────────────────

    def _render_origem_header(self, id_parada, recursos_raw):
        parada_desc = self._parada_info(id_parada)
        recursos = []
        try:
            recursos = list(recursos_raw[0]["Recursos"]) if recursos_raw else []
        except:
            pass

        frm = tk.Frame(self.results_frame, bg=C["accent_lt"],
                       padx=20, pady=14)
        frm.pack(fill="x", pady=(0, 16))

        top = tk.Frame(frm, bg=C["accent_lt"])
        top.pack(fill="x")

        tk.Label(top, text="📍  Ponto de Origem",
                 font=FONT_BADGE, fg=C["accent"], bg=C["accent_lt"]).pack(side="left")

        tk.Label(frm, text=parada_desc,
                 font=FONT_HEAD, fg=C["primary"], bg=C["accent_lt"]).pack(anchor="w", pady=(4, 2))

        tk.Label(frm, text="Destino: CI/UFPB — Campus I · Bancários",
                 font=FONT_SMALL, fg=C["text2"], bg=C["accent_lt"]).pack(anchor="w")

        if recursos:
            acc_row = tk.Frame(frm, bg=C["accent_lt"])
            acc_row.pack(anchor="w", pady=(8, 0))
            tk.Label(acc_row, text="♿ Acessibilidade na parada:",
                     font=FONT_SMALL, fg=C["text2"], bg=C["accent_lt"]).pack(side="left")
            for r in recursos:
                badge(acc_row, str(r), bg=C["badge_acc"]).pack(side="left", padx=3)

    def _render_section_title(self, texto, cor):
        frm = tk.Frame(self.results_frame, bg=C["bg"])
        frm.pack(fill="x", pady=(10, 4))
        tk.Label(frm, text=texto, font=FONT_SUB, fg=cor, bg=C["bg"]).pack(anchor="w")
        tk.Frame(frm, bg=cor, height=2).pack(fill="x", pady=2)

    def _render_card_direta(self, linha):
        card = tk.Frame(self.results_frame, bg=C["surface"],
                        relief="flat", bd=0, padx=20, pady=16)
        card.pack(fill="x", pady=6)

        stripe = tk.Frame(card, bg=C["success"], width=5)
        stripe.pack(side="left", fill="y")

        body = tk.Frame(card, bg=C["surface"], padx=14)
        body.pack(side="left", fill="both", expand=True)

        title_row = tk.Frame(body, bg=C["surface"])
        title_row.pack(fill="x")
        badge(title_row, "DIRETA", bg=C["success"]).pack(side="left")
        nome = self._nome_linha(linha)
        tk.Label(title_row, text=f"  Linha {linha} — {nome}",
                 font=FONT_HEAD, fg=C["text"], bg=C["surface"]).pack(side="left", padx=6)

        separator(body)

        info = self._info_linha(linha)
        self._render_info_grid(body, info)

        sep2 = tk.Frame(body, bg=C["success_lt"], pady=6, padx=8)
        sep2.pack(fill="x", pady=(8, 0))
        tk.Label(sep2, text="✅  Embarque na parada selecionada → Desembarque no CI/UFPB",
                 font=FONT_SMALL, fg=C["success"], bg=C["success_lt"]).pack(anchor="w")

    def _render_card_baldeacao(self, l1, id_b, l2):
        card = tk.Frame(self.results_frame, bg=C["surface"],
                        relief="flat", bd=0, padx=20, pady=16)
        card.pack(fill="x", pady=6)

        stripe = tk.Frame(card, bg=C["warning"], width=5)
        stripe.pack(side="left", fill="y")

        body = tk.Frame(card, bg=C["surface"], padx=14)
        body.pack(side="left", fill="both", expand=True)

        title_row = tk.Frame(body, bg=C["surface"])
        title_row.pack(fill="x")
        badge(title_row, "BALDEAÇÃO", bg=C["warning"]).pack(side="left")

        nome1 = self._nome_linha(l1)
        nome2 = self._nome_linha(l2)
        tk.Label(title_row, text=f"  Linha {l1} → Linha {l2}",
                 font=FONT_HEAD, fg=C["text"], bg=C["surface"]).pack(side="left", padx=6)

        separator(body)

        tk.Label(body, text="1ª LINHA",
                 font=FONT_BADGE, fg=C["text2"], bg=C["surface"]).pack(anchor="w", pady=(4, 2))
        tk.Label(body, text=f"Linha {l1} — {nome1}",
                 font=FONT_SUB, fg=C["text"], bg=C["surface"]).pack(anchor="w")
        info1 = self._info_linha(l1)
        self._render_info_grid(body, info1)

        ponto_desc = self._parada_info(id_b)
        recursos_b = self._recursos_parada(id_b)
        troca = tk.Frame(body, bg=C["warning_lt"], padx=10, pady=8)
        troca.pack(fill="x", pady=10)
        tk.Label(troca, text="🔄  Ponto de Baldeação",
                 font=FONT_BADGE, fg=C["warning"], bg=C["warning_lt"]).pack(anchor="w")
        tk.Label(troca, text=ponto_desc,
                 font=FONT_SUB, fg=C["text"], bg=C["warning_lt"]).pack(anchor="w", pady=2)
        if recursos_b:
            acc = tk.Frame(troca, bg=C["warning_lt"])
            acc.pack(anchor="w")
            tk.Label(acc, text="♿ Acessibilidade: ",
                     font=FONT_SMALL, fg=C["text2"], bg=C["warning_lt"]).pack(side="left")
            for r in recursos_b:
                badge(acc, str(r), bg=C["badge_acc"]).pack(side="left", padx=2)

        tk.Label(body, text="2ª LINHA",
                 font=FONT_BADGE, fg=C["text2"], bg=C["surface"]).pack(anchor="w", pady=(4, 2))
        tk.Label(body, text=f"Linha {l2} — {nome2}",
                 font=FONT_SUB, fg=C["text"], bg=C["surface"]).pack(anchor="w")
        info2 = self._info_linha(l2)
        self._render_info_grid(body, info2)

        inst = tk.Frame(body, bg=C["warning_lt"], pady=6, padx=8)
        inst.pack(fill="x", pady=(8, 0))
        tk.Label(inst,
                 text=f"⚡  Origem → Linha {l1} → Troca em {ponto_desc} → Linha {l2} → CI/UFPB",
                 font=FONT_SMALL, fg=C["warning"], bg=C["warning_lt"]).pack(anchor="w")

    def _render_info_grid(self, parent, info):
        """Grelha de 2 colunas com tipo, dias, horários."""
        grid = tk.Frame(parent, bg=C["surface"])
        grid.pack(fill="x", pady=4)

        tipo = info.get("Tipo", "N/D")
        dias = info.get("Dias", "N/D")
        h1 = info.get("Primeira", "N/D")
        h2 = info.get("Ultima", "N/D")

        col1 = tk.Frame(grid, bg=C["surface"])
        col1.pack(side="left", padx=(0, 24))
        self._info_item(col1, "🏷️  Tipo", str(tipo))
        self._info_item(col1, "📅  Opera", str(dias))

        col2 = tk.Frame(grid, bg=C["surface"])
        col2.pack(side="left")
        self._info_item(col2, "🕐  Primeira viagem", str(h1))
        self._info_item(col2, "🕗  Última viagem", str(h2))

    def _info_item(self, parent, label, value):
        row = tk.Frame(parent, bg=C["surface"])
        row.pack(anchor="w", pady=1)
        tk.Label(row, text=label, font=FONT_SMALL, fg=C["text2"],
                 bg=C["surface"], width=20, anchor="w").pack(side="left")
        tk.Label(row, text=value, font=FONT_BODY, fg=C["text"],
                 bg=C["surface"]).pack(side="left", padx=4)

    def _render_sem_rota(self):
        frm = tk.Frame(self.results_frame, bg=C["bg"])
        frm.pack(pady=40)
        tk.Label(frm, text="😕", font=("Helvetica", 40), bg=C["bg"]).pack()
        tk.Label(frm, text="Nenhuma rota encontrada para esta parada.",
                 font=FONT_SUB, fg=C["text2"], bg=C["bg"]).pack(pady=6)
        tk.Label(frm, text="Tente selecionar uma parada diferente.",
                 font=FONT_SMALL, fg=C["text3"], bg=C["bg"]).pack()

    # ── Helpers Prolog ────────────────────────

    def _parada_info(self, id_parada):
        try:
            r = list(self.prolog.query(f"parada_info({id_parada}, Desc)"))[0]
            return f"{formatar_id(id_parada)} — {r['Desc']}"
        except:
            return formatar_id(id_parada)

    def _nome_linha(self, linha):
        try:
            r = list(self.prolog.query(f"nome_linha('{linha}', Nome)"))[0]
            return str(r["Nome"])
        except:
            return ""

    def _info_linha(self, linha):
        try:
            r = list(self.prolog.query(f"info_linha('{linha}', Tipo, Dias, Primeira, Ultima)"))[0]
            return {k: str(v) for k, v in r.items()}
        except:
            return {}

    def _recursos_parada(self, id_parada):
        try:
            r = list(self.prolog.query(f"recursos_parada({id_parada}, Recursos)"))[0]
            return list(r["Recursos"])
        except:
            return []


# ──────────────────────────────────────────────
if __name__ == "__main__":
    root = tk.Tk()
    app = CIMapsGUI(root)
    root.mainloop()