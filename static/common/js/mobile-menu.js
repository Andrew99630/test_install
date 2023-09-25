const hamburgerMenu = document.querySelector('.hamburger-menu');
const menu = document.querySelector('.main-menu');

hamburgerMenu.addEventListener('click', () => {
  menu.classList.toggle('show');
});

function toggleMenuIcon() {
  hamburgerMenu.classList.toggle('active')
}

hamburgerMenu.addEventListener('click', toggleMenuIcon);

document.addEventListener('click', (event) => {
  // Проверяем, был ли клик вне меню
  if (!menu.contains(event.target) && event.target !== hamburgerMenu) {
    menu.classList.remove('show');
    if (hamburgerMenu.classList.contains('active')) {
      toggleMenuIcon(); // Если меню было открыто, возвращаем иконку в исходное состояние
    }
  }
});