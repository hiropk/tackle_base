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

function toggleRodSearchForm() {
  const toggleButton = document.getElementById("toggle_search_form");
  const searchForm = document.getElementById("rod_search_form");

  toggleButton.addEventListener("click", function () {
    if (searchForm.classList.contains("hidden")) {
      searchForm.classList.remove("hidden");
      toggleButton.textContent = "検索フォームOFF";
    } else {
      searchForm.classList.add("hidden");
      toggleButton.textContent = "検索フォームON";
    }
  });
}

document.addEventListener("DOMContentLoaded", function () {
  handleHamburgerMenu();
  toggleRodSearchForm();
});

document.addEventListener("turbo:frame-load", function () {
  handleHamburgerMenu();
  toggleRodSearchForm();
});
