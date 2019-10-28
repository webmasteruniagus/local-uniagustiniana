const swiperTop = document.querySelector(".products-gallery--top");
const swiperThumbs = document.querySelector(".products-gallery--thumbs");

document.onreadystatechange = function() {
  if (swiperTop) {
    const galleryThumbs = new Swiper(".products-gallery--thumbs", {
      spaceBetween: 10,
      slidesPerView: 4,
      watchSlidesVisibility: true,
      watchSlidesProgress: true,
    });

    const galleryTop = new Swiper(".products-gallery--top", {
      spaceBetween: 10,
      slidesPerView: 1,
      thumbs: {
        swiper: galleryThumbs,
      },
    });
  }
}
