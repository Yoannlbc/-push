// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener('turbo:load', function () {
  const carousel = document.querySelector('#carouselExampleInterval');
  if (carousel) {
    const bsCarousel = bootstrap.Carousel.getOrCreateInstance(carousel, {
      interval: false,  // ← désactive l'autoplay
      ride: false,
      touch: true,
      pause: false,
      wrap: true
    });
  }
});
