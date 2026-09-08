class Product {
  final String id;
  final String name;
  final int price; // In Taka (৳)
  final double rating;
  final int reviewCount;
  final String imagePath;
  final String mainCategory; // e.g. 'Cats', 'Dogs'
  final String subCategory;  // e.g. 'Food', 'Kitten', 'Toys', 'Accessories', 'Litter'
  final String? nestedCategory; // e.g. 'Wet Food', 'Dry Food', 'Can Food', 'Milk', 'Feeder'
  final String? badge; // e.g. 'Best Seller', '-20%'
  final bool isFavorite;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.imagePath,
    required this.mainCategory,
    required this.subCategory,
    this.nestedCategory,
    this.badge,
    this.isFavorite = false,
  });
}
