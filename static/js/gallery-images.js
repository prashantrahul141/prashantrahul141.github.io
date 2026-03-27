document.addEventListener("DOMContentLoaded", () => {
  const grid = document.querySelector('.gallery');

  function resizeAll() {
    const rowHeight = parseInt(getComputedStyle(grid).getPropertyValue('grid-auto-rows'));
    const rowGap = parseInt(getComputedStyle(grid).getPropertyValue('gap'));

    document.querySelectorAll('.gallery-item').forEach(item => {
      const img = item.querySelector('img');

      const resize = () => {
        const width = item.clientWidth;
        const height = img.naturalHeight / img.naturalWidth * width;
        const rowSpan = Math.ceil((height + rowGap) / (rowHeight + rowGap));
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
