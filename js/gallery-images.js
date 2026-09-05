document.addEventListener("DOMContentLoaded", () => {
  const grid = document.querySelector('.gallery');

  function resizeAll() {
    const rowHeight = parseInt(getComputedStyle(grid).getPropertyValue('grid-auto-rows'));
    const rowGap = parseInt(getComputedStyle(grid).getPropertyValue('gap'));

    document.querySelectorAll('.gallery-item').forEach(item => {
      const img = item.querySelector('img');

      const resize = () => {
        const content = item.querySelector('.gallery-content');
        const totalHeight = content.getBoundingClientRect().height;
        const rowSpan = Math.ceil((totalHeight + rowGap) / (rowHeight + rowGap));
        item.style.gridRowEnd = `span ${rowSpan}`;
      };

      if (img.complete) {
        resize();
      } else {
        img.onload = resize;
      }
    });

    grid.classList.add('ready');
  }

  window.addEventListener('load', resizeAll);
  window.addEventListener('resize', resizeAll);
});
