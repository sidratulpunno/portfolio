# SEO Portfolio — Sidratul Punno

Static, SEO-friendly + AI-crawler-friendly rebuild of the Flutter portfolio, ready for **GitHub Pages**.

Folder: `seo_portfolio/`

## Why this version ranks better than Flutter web

Flutter web renders to `<canvas>` — Google / Bing / AI crawlers (GPTBot, ClaudeBot, PerplexityBot) see almost no text.
This version is:

- **Semantic HTML5**: one `<h1>`, proper `<h2>/<h3>` hierarchy, `<header>/<main>/<section>/<article>/<footer>`, `<time datetime>`, `<address>`
- **Full meta**: title, description, keywords, canonical, Open Graph, Twitter cards, `theme-color`, `robots`
- **JSON-LD structured data**: `Person` + `WebSite` + 3× `ScholarlyArticle` + `ItemList` projects + `FAQPage` (rich results + AI answers)
- **Crawler files**: `robots.txt` (allows GPTBot/ClaudeBot/PerplexityBot), `sitemap.xml`, `llms.txt`, `humans.txt`, `manifest.webmanifest`, `404.html`, `.nojekyll`
- **Performance**: no framework, 2 tiny files (`styles.css` ~8KB, `script.js` ~2KB), `loading="lazy"` images, system fonts, `prefers-reduced-motion` support
- **Accessibility**: skip link, aria labels, focus styles, keyboard nav — all ranking signals

## Contents (mirrors Flutter app 1:1)

About, Skills (6 categories), Publications (3), Projects (5, each opens a details popup), Achievements (4), Certifications (14) + Badges (2), Contact. Same text as `lib/data/resume_data.dart`.

## Deploy to GitHub Pages (2 options)

### Option A — separate repo (recommended)
1. Create new repo, e.g. `sidratulpunno.github.io` (user site) or `portfolio-seo`.
2. Copy **contents** of `seo_portfolio/` to repo root (not the folder itself).
3. Push to `main`.
4. Repo → Settings → Pages → Deploy from branch → `main` / `/ (root)` → Save.
5. URL: `https://<username>.github.io/` or `https://<username>.github.io/portfolio-seo/`.

### Option B — same repo, `/seo` subpath
1. Copy `seo_portfolio/` into your existing repo.
2. Pages → deploy `main` root; site lives at `.../seo_portfolio/`.

## Before going live — 3 replacements

1. Replace `https://sidratulpunno.github.io/` in:
   - `index.html` (canonical, og:url, og:image, JSON-LD `@id`/`url`)
   - `sitemap.xml` (`<loc>` entries)
   - `robots.txt` (`Sitemap:` line)
2. OG image: `assets/og-cover.svg` is included. For best LinkedIn/X previews export a 1200×630 PNG as `assets/og-cover.png` (SVG works on most, PNG works everywhere) — or point `og:image` to the `.svg`.
3. Optional: add Google Search Console + Bing Webmaster verification `<meta>` tags in `<head>`.

## Local preview

```powershell
Set-Location seo_portfolio
python -m http.server 8000
# open http://localhost:8000/
```

## Validate SEO

- Rich Results Test: https://search.google.com/test/rich-results → paste URL
- Schema validator: https://validator.schema.org/
- PageSpeed: https://pagespeed.web.dev/
- `llms.txt` check: open `/llms.txt`, `/robots.txt`, `/sitemap.xml` after deploy.
