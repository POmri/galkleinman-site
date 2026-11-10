/* galkleinman.com — site behaviour */
(function () {
  document.documentElement.classList.remove("no-js");

  // Mobile menu
  var toggle = document.querySelector(".menu-toggle");
  var nav = document.getElementById("site-nav");

  function setMenu(open) {
    toggle.setAttribute("aria-expanded", String(open));
    toggle.setAttribute("aria-label", open ? "Close menu" : "Open menu");
    nav.classList.toggle("is-open", open);
  }

  if (toggle && nav) {
    toggle.addEventListener("click", function () {
      setMenu(toggle.getAttribute("aria-expanded") !== "true");
    });

    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape" && nav.classList.contains("is-open")) {
        setMenu(false);
        toggle.focus();
      }
    });

    window.matchMedia("(min-width: 768px)").addEventListener("change", function (mq) {
      if (mq.matches) setMenu(false);
    });
  }

  // Keep the copyright year current
  document.querySelectorAll("[data-year]").forEach(function (el) {
    el.textContent = new Date().getFullYear();
  });

  // When the site is opened straight from disk (file://), folder links
  // like "about/" need "index.html" added so they open the page.
  if (location.protocol === "file:") {
    document.querySelectorAll("a[href]").forEach(function (a) {
      var href = a.getAttribute("href");
      if (/^(https?:|mailto:|#)/.test(href)) return;
      if (href.slice(-1) === "/") a.setAttribute("href", href + "index.html");
    });
  }
})();
