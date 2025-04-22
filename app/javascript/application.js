// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener('turbo:load', function () {
  const carousel = document.querySelector('#carouselExampleInterval');
  if (carousel) {
    const bsCarousel = bootstrap.Carousel.getOrCreateInstance(carousel, {
      interval: false,
      ride: false,
      touch: true,
      pause: false,
      wrap: true
    });
  }
});

document.addEventListener('DOMContentLoaded', function() {
  const photoInput = document.getElementById('user-photo-upload');

  if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
    photoInput.setAttribute('capture', 'camera');
  }

  photoInput.addEventListener('change', function(e) {
    if (this.files && this.files[0]) {
      const form = document.getElementById('avatar-form');
      form.submit();
    }
  });
});

document.addEventListener('DOMContentLoaded', function() {
  // Récupérer l'élément d'image et l'input file
  const vinylPreview = document.getElementById('vinyl-preview');
  const photoUpload = document.getElementById('photo-upload');

  // Ajouter un écouteur d'événement au clic sur l'image pour déclencher l'input file
  if (vinylPreview) {
    vinylPreview.addEventListener('click', function() {
      photoUpload.click();
    });
  }
});

// Fonction pour prévisualiser la photo sélectionnée
function previewPhoto(input) {
  if (input.files && input.files[0]) {
    const reader = new FileReader();

    reader.onload = function(e) {
      const vinylPreview = document.getElementById('vinyl-preview');
      vinylPreview.src = e.target.result;
    };

    reader.readAsDataURL(input.files[0]);
  }
}
