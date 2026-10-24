# Documentation assets

This folder keeps the non-code deliverables of the project. Everything here is meant to be opened
directly — no build step, no server.

## `product/`

The three requirement documents written before implementation:

| File | Purpose |
| :-- | :-- |
| `BRD-商业需求文档.docx` | Business context, market opportunity, stakeholder value |
| `MRD-市场需求文档.docx` | Target users, competitor scan, demand breakdown |
| `PRD-产品需求文档.docx` | Feature inventory, page list, field-level rules |

They are `.docx` (Word / WPS / LibreOffice). The Chinese file names are intentional — these were
written for a Chinese-language product.

## `prototype/`

Two Axure RP exports, one per client:

```
prototype/
├── 智点外卖_用户端/index.html      customer app — 14 screens + flow diagrams
└── 智点外卖_管理端/index.html      merchant console — 16 screens
```

Open `index.html` in any modern browser. The export is fully self-contained: page data lives in
`data/`, runtime in `resources/` and `plugins/`, artboards in `images/`. Browsing works offline from
a local checkout; if your browser restricts `file://` scripts, serve the folder instead:

```bash
# from the repository root
python -m http.server 8000
# then open http://localhost:8000/docs/prototype/智点外卖_用户端/index.html
```

Useful entry points inside the customer prototype:

- `页面流转图.html` — the full screen-to-screen flow with annotations
- `功能结构图.html` — feature tree
- `业务流程图.html` — business process
- `首页_1.html` — open / busy / closed home states
- `提交订单.html` — checkout rules (delivery slots, remarks, cutlery)

## `images/`

Screenshots referenced by the README files. They were rendered from the Axure prototype with headless
Chrome, then cropped — so what you see in the documentation is exactly what the prototype specifies.
