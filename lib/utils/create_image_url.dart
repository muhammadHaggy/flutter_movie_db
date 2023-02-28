String createImageUrl({int size = 500, required String imageLink}) {
  return 'https://image.tmdb.org/t/p/w${size}${imageLink}';
}
