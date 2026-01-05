document.addEventListener("DOMContentLoaded", function () {
    const images = document.querySelectorAll(".gallery-img");

    images.forEach(img => {
        if (img.complete) {
            updateImageClass(img);
        } else {
            img.onload = () => updateImageClass(img);
        }
    });

    function updateImageClass(img) {
        let aspectRatio = img.naturalWidth / img.naturalHeight;
        let parent = img.closest(".gallery-item");

        if (aspectRatio > 1.2) {
            parent.classList.add("landscape");
        } else {
            parent.classList.add("portrait");
        }
    }
});
