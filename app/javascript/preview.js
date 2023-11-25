document.addEventListener("DOMContentLoaded", (event) => {
  const inputFile = document.querySelector("#repertoire_repertoire_image");
  const previewImage = document.querySelector("#preview");

  inputFile.addEventListener("change", (event) => {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (event) => {
        previewImage.src = event.target.result;
      };
      reader.readAsDataURL(file);
    }
  });
});
