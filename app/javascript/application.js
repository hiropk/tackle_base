// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";

// ハンバーガーメニューの処理
function handleHamburgerMenu() {
  const $hamburgerMenu = $("#hamburger-menu");
  const $mobileNav = $("#mobile-nav");
  const $menuLinks = $(".mobile-nav ul li a");

  $hamburgerMenu.on("click", function (event) {
    event.stopPropagation();
    $mobileNav.toggleClass("show");
  });

  $menuLinks.on("click", function () {
    $mobileNav.removeClass("show");
  });

  $(document).on("click", function (event) {
    if (
      !$.contains($mobileNav[0], event.target) &&
      !$.contains($hamburgerMenu[0], event.target)
    ) {
      $mobileNav.removeClass("show");
    }
  });
}

// セクションの表示・非表示を切り替える処理
function toggleSection() {
  const userId = $("body").data("userId");
  const sectionKeys = ["tackle", "rod", "reel", "line", "leader"];
  const storageKey = `section-visibility-${userId}`;

  let visibilityState = JSON.parse(localStorage.getItem(storageKey)) || {};

  sectionKeys.forEach((key) => {
    if (visibilityState[key] === undefined) {
      visibilityState[key] = false;
    }
  });

  // 初期反映
  sectionKeys.forEach((key) => {
    const $sectionEl = $(`[data-section="${key}"]`).parent().parent();
    if ($sectionEl.length === 0) return;

    const $content = $sectionEl.find(".section-content");
    const $iconOpen = $sectionEl.find(".icon-open");
    const $iconClose = $sectionEl.find(".icon-close");
    const visible = visibilityState[key];

    $content.toggleClass("hidden", !visible);
    $iconOpen.toggleClass("hidden", visible);
    $iconClose.toggleClass("hidden", !visible);
  });

  // イベントリスナー
  $(".toggle-btn").on("click", function () {
    const key = $(this).data("section");
    const $sectionEl = $(`[data-section="${key}"]`).parent().parent();
    const $content = $sectionEl.find(".section-content");
    const $iconOpen = $sectionEl.find(".icon-open");
    const $iconClose = $sectionEl.find(".icon-close");

    const isVisible = !$content.hasClass("hidden");
    const newState = !isVisible;

    $content.toggleClass("hidden", !newState);
    $iconOpen.toggleClass("hidden", newState);
    $iconClose.toggleClass("hidden", !newState);

    // 保存
    visibilityState[key] = newState;
    localStorage.setItem(storageKey, JSON.stringify(visibilityState));
  });
}

// 検索フォームの表示・非表示を切り替える処理
function toggleSearchForm(items) {
  const $toggleButton = $(`#toggle_search_${items}_form`);
  const $searchForm = $(`#search_${items}_form`);

  if ($toggleButton.length === 0) {
    return;
  }

  $toggleButton.on("click", function () {
    $searchForm.toggleClass("hidden");
  });
}

$(document).on("turbo:load turbo:frame-load", function () {
  handleHamburgerMenu();
  toggleSection();

  // 各セクションの検索フォームを初期化
  ["tackles", "rods", "reels", "lines", "leaders"].forEach(function (items) {
    toggleSearchForm(items);
  });
});
