import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';
import '../data/wishlist_data.dart';
import '../data/cart_data.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String price;
  final String rating;
  final String imagePath;
  final String? badge;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    required this.imagePath,
    this.badge,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    bool isFavorite = wishListItems.any((item) => item.name == widget.name);

    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  widget.imagePath,
                  height: 75, // হাইট সামান্য কমানো হলো ওভারফ্লো এড়াতে
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (widget.badge != null)
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      widget.badge!,
                      style: TextStyles.small.copyWith(color: AppColors.white, fontSize: 8),
                    ),
                  ),
                ),
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isFavorite) {
                        wishListItems.removeWhere((item) => item.name == widget.name);
                      } else {
                        wishListItems.add(
                          WishlistItem(
                            name: widget.name,
                            price: widget.price,
                            imagePath: widget.imagePath,
                          ),
                        );
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 4),
                      ],
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyles.body.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  widget.price,
                  style: TextStyles.body.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, size: 11, color: AppColors.warning),
                        const SizedBox(width: 2),
                        Text(widget.rating, style: const TextStyle(fontSize: 10)),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          var existingItem = cartItems.firstWhere(
                                (item) => item.name == widget.name,
                            orElse: () => CartItem(name: '', price: '', imagePath: '', quantity: 0),
                          );

                          if (existingItem.name.isNotEmpty) {
                            existingItem.quantity++;
                          } else {
                            cartItems.add(
                              CartItem(
                                name: widget.name,
                                price: widget.price,
                                imagePath: widget.imagePath,
                                quantity: 1,
                              ),
                            );
                          }
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to Cart!'),
                            duration: Duration(milliseconds: 600),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.add, size: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}