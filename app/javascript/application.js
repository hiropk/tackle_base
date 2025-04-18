// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";

function handleHamburgerMenu() {
  const hamburgerMenu = document.getElementById("hamburger-menu");
  const mobileNav = document.getElementById("mobile-nav");
  const menuLinks = document.querySelectorAll(".mobile-nav ul li a");

  hamburgerMenu.addEventListener("click", (event) => {
    event.stopPropagation();
    mobileNav.classList.toggle("show");
  });

  menuLinks.forEach((link) => {
    link.addEventListener("click", () => {
      mobileNav.classList.remove("show");
    });
  });

  document.addEventListener("click", (event) => {
    if (
      !mobileNav.contains(event.target) &&
      !hamburgerMenu.contains(event.target)
    ) {
      mobileNav.classList.remove("show");
    }
  });
}

function toggleSection() {
  const userId = document.body.dataset.userId;
  const sectionKeys = ["tackle", "rod", "reel", "line", "leader"];
  const storageKey = `section-visibility-${userId}`;

  // 初期状態取得
  let visibilityState = JSON.parse(localStorage.getItem(storageKey)) || {};

  // デフォルトを false に補完
  sectionKeys.forEach((key) => {
    if (visibilityState[key] === undefined) {
      visibilityState[key] = false;
    }
  });

  // 初期反映
  sectionKeys.forEach((key) => {
    const sectionEl = document.querySelector(`[data-section="${key}"]`)
      .parentElement.parentElement;
    if (!sectionEl) return;

    const content = sectionEl.querySelector(".section-content");
    const iconOpen = sectionEl.querySelector(".icon-open");
    const iconClose = sectionEl.querySelector(".icon-close");
    const visible = visibilityState[key];

    content.classList.toggle("hidden", !visible);
    iconOpen.classList.toggle("hidden", visible);
    iconClose.classList.toggle("hidden", !visible);
  });

  // イベントリスナー
  document.querySelectorAll(".toggle-btn").forEach((btn) => {
    btn.addEventListener("click", () => {
      let key = btn.dataset.section;
      const sectionEl = document.querySelector(`[data-section="${key}"]`)
        .parentElement.parentElement;
      const content = sectionEl.querySelector(".section-content");
      const iconOpen = sectionEl.querySelector(".icon-open");
      const iconClose = sectionEl.querySelector(".icon-close");

      const isVisible = !content.classList.contains("hidden");
      const newState = !isVisible;

      content.classList.toggle("hidden", !newState);
      iconOpen.classList.toggle("hidden", newState);
      iconClose.classList.toggle("hidden", !newState);

      // 保存
      const newKey = key.replace("-btn", "");
      key = newKey;
      visibilityState[key] = newState;
      localStorage.setItem(storageKey, JSON.stringify(visibilityState));
    });
  });
}

function toggleSearchForm(items) {
  const toggleButton = document.getElementById(`toggle_search_${items}_form`);
  const searchForm = document.getElementById(`search_${items}_form`);

  if (toggleButton == null) {
    return;
  }

  toggleButton.addEventListener("click", function () {
    if (searchForm.classList.contains("hidden")) {
      searchForm.classList.remove("hidden");
    } else {
      searchForm.classList.add("hidden");
    }
  });
}

document.addEventListener("turbo:load", function () {
  handleHamburgerMenu();
  toggleSection();

  toggleSearchForm("tackles");
  toggleSearchForm("rods");
  toggleSearchForm("reels");
  toggleSearchForm("lines");
  toggleSearchForm("leaders");
});

document.addEventListener("turbo:frame-load", function () {
  toggleSection();

  toggleSearchForm("tackles");
  toggleSearchForm("rods");
  toggleSearchForm("reels");
  toggleSearchForm("lines");
  toggleSearchForm("leaders");
});
