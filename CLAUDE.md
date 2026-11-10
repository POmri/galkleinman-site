# Notes for Claude

Static portfolio site for Gal Kleinman (designer). Plain HTML/CSS/JS, hosted on GitHub Pages
at galkleinman.com. No build step and no dependencies: keep it that way unless asked.

## Conventions
- Every page is a folder with an `index.html` so URLs match the old WordPress URLs
  (`/about/`, `/moonstone/`, …). Never rename these folders: external links depend on them.
- Pages in subfolders use relative paths starting with `../` (`../css/style.css`,
  `../images/...`). The home page uses no prefix. Links to pages end with a slash (`about/`).
- The header, footer and `<head>` are repeated in every page. When changing one, change all
  eight pages (index, about, six projects). `404.html` uses absolute paths (`/css/style.css`).
- All visual decisions live in the `:root` tokens at the top of `css/style.css`. Prefer
  changing a token over adding one-off values.
- Images go in `images/<page-folder>/`. Always write meaningful `alt` text and use
  `loading="lazy" decoding="async"` on everything below the first screen.
- Voice: headings on the home and about pages are lowercase ("making life simpler through
  design."). Project titles are capitalized; categories are lowercase.
- Standard project page structure: hero image → title + text → image gallery →
  "Back to Top". `recipez/` is a longer case study with its own section layout.
- When adding a project, also add its card to `index.html` and its URL to `sitemap.xml`.
