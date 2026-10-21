# SEO Portfolio — Sidratul Punno

Static, SEO-friendly and AI-crawler-friendly portfolio for **Sheikh Sidratul Muntaha Punno**, ready for **GitHub Pages**.

Folder: `seo_portfolio/`

## Why this ranks better than Flutter web

Flutter web renders to `<canvas>` — Google, Bing, and AI crawlers (GPTBot, ClaudeBot, PerplexityBot) see almost no text. This version is:

- **Semantic HTML5**: one `<h1>`, proper `<h2>/<h3>` hierarchy, `<header>/<main>/<section>/<article>/<footer>`, `<time datetime>`, `<address>`
- **Full meta**: title, description, keywords, canonical, Open Graph, Twitter cards, `theme-color`, `robots`
- **JSON-LD structured data**: `Person` (with all credentials and awards), `WebSite`, 3× `ScholarlyArticle`, `ItemList` projects, `FAQPage`
- **Crawler files**: `robots.txt` (allows GPTBot/ClaudeBot/PerplexityBot), `sitemap.xml`, `llms.txt`, `humans.txt`, `manifest.webmanifest`, `404.html`, `.nojekyll`
- **Performance**: no framework, two small files (`styles.css`, `script.js`), lazy-loaded certificate images, system-font fallbacks, `prefers-reduced-motion`
- **Accessibility**: skip link, aria labels, focus styles, keyboard navigation, mobile menu, reduced-motion support

## Contents (mirrors current CV)

- **About**: current professional summary, open-to roles, research interests, education
- **Skills**: 11 categories from the CV (languages, AI/ML, mobile, backend, embedded systems & IoT, accelerated computing, PCB, OS, typesetting, databases, tools)
- **Publications**: 3 papers with full IEEE venues
- **Projects**: 5 projects (GPU pipeline, quantum/security ×2, assistive navigation, mental health)
- **Achievements**: 4 honors, languages, and 2 extra-curricular activities
- **Certifications**: all 14 certificates retained, including AI Fluency and Claude 101, plus 2 MongoDB/Credly badges
- **Contact**: GitHub, LinkedIn, email, phone, resume

> Note: the CV lists two PCB-design credentials that share the same verification link. Both are kept on the site so nothing is removed.

## Deploy to GitHub Pages

### Option A — separate repo (recommended)
1. Create a new repo, e.g. `sidratulpunno.github.io` or `portfolio-seo`.
2. Copy the **contents** of `seo_portfolio/` to the repo root.
3. Push to `main`.
4. Repo → Settings → Pages → Deploy from branch → `main` / `/(root)` → Save.
5. URL: `https://<username>.github.io/` or `https://<username>.github.io/portfolio-seo/`.

### Option B — same repo, `/seo` subpath
1. Copy `seo_portfolio/` into the existing repo.
2. Deploy Pages from `main`; the site lives at `.../seo_portfolio/`.

## Before going live

1. If the final URL is not `https://sidratulpunno.github.io/portfolio/`, update it in:
   - `index.html` (canonical, `og:url`, `og:image`, Twitter image, JSON-LD `@id` / `url`)
   - `sitemap.xml` (`<loc>` entries)
   - `robots.txt` (`Sitemap:` line)
   - `llms.txt` (URL header)
2. Optional: add Google Search Console and Bing Webmaster verification `<meta>` tags in `<head>`.

The Open Graph image is included as `assets/og-cover.png` (1200×630), with `assets/og-cover.svg` as the editable source.

## Local preview

```powershell
Set-Location seo_portfolio
python -m http.server 8000
# open http://localhost:8000/
```

## Validate SEO

- Rich Results Test: https://search.google.com/test/rich-results
- Schema validator: https://validator.schema.org/
- PageSpeed: https://pagespeed.web.dev/
- Check `/llms.txt`, `/robots.txt`, `/sitemap.xml` after deploy.
