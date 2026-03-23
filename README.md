# 🗺️ CI Maps — GPS Universitário

> **Projeto da disciplina de Lógica Aplicada à Computação**  
> Centro de Informática (CI) · Universidade Federal da Paraíba (UFPB)

Sistema de consulta de rotas de ônibus com destino ao **Centro de Informática da UFPB**, combinando uma base de conhecimento em **Prolog** com uma interface gráfica desenvolvida em **Python/Tkinter**.

---

## 📋 Sobre o Projeto

O **CI Maps** é um GPS universitário que responde a uma pergunta simples: *"Que ônibus eu pego para chegar ao CI?"*. O usuário informa seu ponto de origem (uma parada real de João Pessoa/PB) e o sistema retorna as rotas disponíveis — linhas diretas e opções com baldeação —, utilizando inferência lógica via Prolog como motor de busca.

---

## ✨ Funcionalidades

- 🚌 **Rotas diretas** — linhas que saem da origem e chegam direto ao Terminal Quadramares (LIQ/Mangabeira VII)
- 🔄 **Rotas com baldeação** — combinações de duas linhas com ponto de troca intermediário
- 🔍 **Busca por ponto de origem** — seleção por dropdown com todos os pontos cadastrados
- ✅ **Verificação de integridade** — validação automática da base de conhecimento ao iniciar
- 🖥️ **Interface gráfica** — UI com tema visual da UFPB (azul institucional)

---

## 🧠 Arquitetura

O projeto segue uma separação entre lógica e apresentação:

```
CI-Maps/
├── Main.py                   # Interface gráfica (Python + Tkinter)
├── ci_logo.png               # Logo do CI/UFPB
├── src/
│   ├── regras.pl             # Regras de inferência Prolog (motor de busca)
│   ├── dados.pl              # Base de conhecimento (fatos: pontos e linhas)
│   └── interface.pl          # Predicados auxiliares de consulta
├── CoreLogico/
│   └── rotas_ci.pl           # Versão standalone do sistema (uso via terminal)
└── testes/
    └── testes.pl             # Suite de testes automatizados em Prolog
```

### Camada lógica (Prolog)

A inteligência do sistema vive em três predicados principais:

| Predicado | Descrição |
|-----------|-----------|
| `rota_direta(+Origem, -Linha)` | Verdadeiro se existe uma linha direta de `Origem` ao CI |
| `rota_com_baldeacao(+Origem, -L1, -PontoBaldeacao, -L2)` | Verdadeiro se existe a combinação `Origem → L1 → Troca → L2 → CI` |
| `existe_rota(+Origem)` | Verdadeiro se há qualquer rota partindo de `Origem` |
| `buscar_pontos_aproximados(+Fragmento, -Lista)` | Busca parcial de pontos pelo nome |

### Camada de apresentação (Python)

A interface `Main.py` utiliza **PySwip** para se comunicar com o interpretador Prolog e exibir os resultados em um layout de cards com scroll.

---

## 🛠️ Tecnologias

- **SWI-Prolog** — Motor de inferência lógica
- **Python 3** — Interface gráfica e integração
- **Tkinter** — Biblioteca de GUI (nativa do Python)
- **PySwip** — Bridge Python ↔ SWI-Prolog

---

## ⚙️ Como executar

### Pré-requisitos

```bash
# Instalar SWI-Prolog
sudo apt install swi-prolog        # Ubuntu/Debian
brew install swi-prolog            # macOS

# Instalar dependência Python
pip install pyswip
```

### Rodando a interface gráfica

```bash
git clone https://github.com/seu-usuario/CI-Maps.git
cd CI-Maps
python Main.py
```

### Rodando via terminal (Prolog puro)

```prolog
?- consult('CoreLogico/rotas_ci.pl').
?- consultar('Av. Epitácio Pessoa (Tambaú)').
?- consultar('Av. Dom Pedro II (Centro)').
?- listar_pontos.
```

### Rodando os testes

```bash
swipl -g "consult('testes/testes.pl'), halt."
```

---

## 📌 Linhas cadastradas

As linhas de ônibus da Unitrans/João Pessoa cobertas pela base de conhecimento incluem, entre outras:

| Linha | Itinerário |
|-------|-----------|
| 203 | Mangabeira VII ↔ José Américo ↔ Rangel ↔ Varadouro |
| 207 | Penha Via Seixas ↔ Mangabeira ↔ Rangel ↔ Varadouro |
| 304 | Mangabeira Shopping ↔ Bancários ↔ UFPB Castelo Branco ↔ Varadouro |
| 508 | Penha Via Jacarapé ↔ Epitácio Pessoa ↔ Mangabeira Shopping |
| 520 | Altiplano ↔ Av. Epitácio Pessoa ↔ Varadouro |

> O destino fixo de todas as rotas é o **Terminal Quadramares - LIQ (Mangabeira VII)**, localizado no CI/UFPB.

---

## 📚 Conceitos de Lógica Aplicada

Este projeto demonstra na prática os seguintes conceitos da disciplina:

- **Fatos e regras** — modelagem do domínio de transporte público em lógica de predicados
- **Unificação e backtracking** — mecanismo de busca automática de rotas pelo SWI-Prolog
- **Negação por falha (`\+`)** — filtragem de linhas que *não* chegam ao CI para o caso de baldeação
- **Integridade da base** — verificação declarativa com `forall/2` na carga do arquivo
- **Separação fatos/regras** — `dados.pl` contém apenas fatos; `regras.pl` contém apenas inferências

---

## 👥 Autores

Desenvolvido como projeto da disciplina **Lógica Aplicada à Computação** do curso de Ciência da Computação — Centro de Informática, UFPB.

---

## 📄 Licença

Distribuído sob a licença definida no arquivo [LICENSE](LICENSE).
