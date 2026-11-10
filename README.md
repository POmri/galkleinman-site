# galkleinman.com

The portfolio site of Gal Kleinman, moved from WordPress to plain HTML, CSS and JavaScript.
No build step, no framework, no plugins: open a file, edit it, push it.

## ⚠️ First: save the images before leaving WordPress

The pages point to images in an `images/` folder that doesn't exist yet. The download
script copies all 80 images (and the favicon) from the live WordPress site into it.
**Run it while WordPress is still online.**

```bash
# macOS / Linux
bash scripts/download-images.sh
```

```powershell
# Windows
powershell -ExecutionPolicy Bypass -File scripts\download-images.ps1
```

It's safe to run more than once; images already downloaded are skipped.
Then commit the `images/` folder along with everything else.

## Project structure

```
index.html                  Home (Work)
about/index.html            About
moonstone/index.html        Project pages, one folder each,
silver-spoon/index.html     so the URLs stay exactly the same
camilo/index.html           as on WordPress (galkleinman.com/camilo/ etc.)
recipez/index.html          UX/UI case study (longer, custom layout)
givatayim-theatre/index.html
climate-crisis-campaign/index.html
404.html                    "Page not found" (also fixes old /Moonstone/-style links)
css/style.css               All styling. Design tokens are at the top.
js/main.js                  Mobile menu, footer year, local preview fix
images/<project>/           Images, grouped by page
scripts/                    Image download scripts + list of image URLs
sitemap.xml, robots.txt     For search engines
```

## Preview locally

Double-click `index.html`; it works straight from disk.
For the most accurate preview, run a tiny local server from the project folder:

```bash
python3 -m http.server 8000     # then open http://localhost:8000
```

(Or use the "Live Server" extension in VS Code.)

## Customize

Everything visual is controlled from the top of `css/style.css`:

| Token | What it changes |
|---|---|
| `--font-sans` | The typeface (also update the Google Fonts `<link>` in each page's `<head>`) |
| `--color-text`, `--color-bg`, `--color-muted` | Text, background and secondary text colors |
| `--fs-display`, `--fs-h1`, `--fs-h2`, `--fs-body` | Type sizes |
| `--container`, `--gutter` | Page width and side margins |
| `--gap-grid`, `--gap-images`, `--space-section` | Spacing |

### Add a new project

1. Copy a project folder (e.g. `camilo/`) and rename it, e.g. `new-project/`.
2. Edit the title, text and image list in `new-project/index.html`.
3. Put its images in `images/new-project/`.
4. Add a card for it in `index.html` (copy an existing `<li class="work-card">` block).
5. Add its URL to `sitemap.xml`.

## Put it on GitHub and go live

1. Create a new repository on GitHub and push this folder to it.
2. In the repo: **Settings → Pages → Build and deployment → Source: Deploy from a branch**,
   choose `main` and `/ (root)`, then **Save**. After a minute the site is live at
   `https://<your-username>.github.io/<repo-name>/`. Check that everything looks right there.
3. Move your domain: in **Settings → Pages → Custom domain**, enter `galkleinman.com` and save.
   Then, at your domain registrar, replace the old WordPress DNS records with GitHub's:
   - `A` records for `@` pointing to `185.199.108.153`, `185.199.109.153`,
     `185.199.110.153`, `185.199.111.153`
   - a `CNAME` record for `www` pointing to `<your-username>.github.io`

   (Double-check the current values in GitHub's docs:
   https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)
4. When the domain works, tick **Enforce HTTPS** in the same settings page.
5. Only then cancel the WordPress hosting.

## Editing with Claude

`CLAUDE.md` describes how this project is organized, so Claude (in Claude Code or a chat
where you share the files) can make changes consistently: "add a new project called X",
"make the headlines bigger", "switch the font to …".
