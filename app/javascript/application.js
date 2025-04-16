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

function toggleSection(head) {
  const toggleSectionAddIcon = document.getElementById(
    `toggle_${head}_add_icon`
  );
  const toggleSectionRemoveIcon = document.getElementById(
    `toggle_${head}_remove_icon`
  );
  const section = document.getElementById(`toggle_${head}`);

  if (toggleSectionAddIcon == null || toggleSectionRemoveIcon == null) {
    return;
  }

  toggleSectionAddIcon.addEventListener("click", function () {
    if (section.classList.contains("hidden")) {
      section.classList.remove("hidden");
      toggleSectionAddIcon.classList.add("hidden");
      toggleSectionRemoveIcon.classList.remove("hidden");
    }
  });

  toggleSectionRemoveIcon.addEventListener("click", function () {
    if (!section.classList.contains("hidden")) {
      section.classList.add("hidden");
      toggleSectionAddIcon.classList.remove("hidden");
      toggleSectionRemoveIcon.classList.add("hidden");
    }
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
  toggleSection("tackle");
  toggleSection("rod");
  toggleSection("reel");
  toggleSection("line");
  toggleSection("leader");

  toggleSearchForm("tackles");
  toggleSearchForm("rods");
  toggleSearchForm("reels");
  toggleSearchForm("lines");
  toggleSearchForm("leaders");
});

document.addEventListener("turbo:frame-load", function () {
  toggleSection("tackle");
  toggleSection("rod");
  toggleSection("reel");
  toggleSection("line");
  toggleSection("leader");

  toggleSearchForm("tackles");
  toggleSearchForm("rods");
  toggleSearchForm("reels");
  toggleSearchForm("lines");
  toggleSearchForm("leaders");
});
