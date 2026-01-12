document.addEventListener("DOMContentLoaded", () => {

    const fileInput = document.querySelector('input[type="file"]');
    const img = document.getElementById("avatarPreview");
    const mask = document.getElementById("avatarMask");
    const zoom = document.getElementById("zoomRange");

    const scaleInput = document.getElementById("imgScale");
    const xInput = document.getElementById("imgX");
    const yInput = document.getElementById("imgY");

    let scale = 1;
    let posX = 0;
    let posY = 0;
    let dragging = false;
    let startX, startY;

    function updateTransform() {
        img.style.transform =
            `translate(${posX}px, ${posY}px) scale(${scale})`;

        scaleInput.value = scale;
        xInput.value = posX;
        yInput.value = posY;
    }

    /* AUTO-FIT IMAGE INTO CIRCLE */
    function fitImage() {
        const maskSize = mask.offsetWidth;
        const imgWidth = img.naturalWidth;
        const imgHeight = img.naturalHeight;

        const scaleX = maskSize / imgWidth;
        const scaleY = maskSize / imgHeight;

        // Cover the circle
        scale = Math.max(scaleX, scaleY);

        zoom.min = scale;
        zoom.max = scale * 10.5;
        zoom.value = scale;

        posX = 0;
        posY = 0;

        updateTransform();
    }

    /* FILE PREVIEW */
    fileInput.addEventListener("change", () => {
        const file = fileInput.files[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onload = () => {
            img.onload = fitImage;
            img.src = reader.result;
        };
        reader.readAsDataURL(file);
    });

    /* ZOOM */
    zoom.addEventListener("input", () => {
        scale = parseFloat(zoom.value);
        updateTransform();
    });

    /* DRAG */
    mask.addEventListener("mousedown", e => {
        dragging = true;
        startX = e.clientX - posX;
        startY = e.clientY - posY;
    });

    document.addEventListener("mousemove", e => {
        if (!dragging) return;
        posX = e.clientX - startX;
        posY = e.clientY - startY;
        updateTransform();
    });

    document.addEventListener("mouseup", () => dragging = false);

});
