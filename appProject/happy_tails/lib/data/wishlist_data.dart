// উইশলিস্টের ডাটা রাখার জন্য আমরা এখানেই একটি সিম্পল ক্লাস বানিয়ে নিলাম
class WishlistItem {
  final String name;
  final String price;
  final String imagePath;

  WishlistItem({
    required this.name,
    required this.price,
    required this.imagePath,
  });
}

// এই গ্লোবাল লিস্টে আমরা উইশলিস্টের প্রোডাক্টগুলো সেভ করে রাখব
List<WishlistItem> wishListItems = [];