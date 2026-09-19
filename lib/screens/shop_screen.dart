import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';
import 'package:happy_tails/data/cat_products.dart';
import 'package:happy_tails/models/product.dart';
import 'package:happy_tails/data/cart_data.dart';

class ShopScreen extends StatefulWidget {
  final String initialCategory;
  const ShopScreen({super.key, this.initialCategory = 'Dogs'});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  TextEditingController searchController = TextEditingController();
  String selectedCategory = 'Dogs';

  List<String> categories = ['Dogs', 'Cats', 'Birds', 'Bunnies', 'Fish'];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = [];
    for (var product in catProductsData) {
      if (product.mainCategory == selectedCategory) {
        if (searchController.text.isEmpty) {
          filteredProducts.add(product);
        } else if (product.name.toLowerCase().contains(searchController.text.toLowerCase())) {
          filteredProducts.add(product);
        }
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Shop',
          style: TextStyles.appTitle.copyWith(color: AppColors.primaryText),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColors.white,
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String category = categories[index];
                bool isSelected = category == selectedCategory;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                      searchController.clear();
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? AppColors.white : AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${filteredProducts.length} Products Found',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(child: Text('No products found.'))
                : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return CustomShopProductCard(product: filteredProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Note theke: StatefulWidget - প্রোডাক্ট কার্ডের জন্য[cite: 1]
class CustomShopProductCard extends StatefulWidget {
  final Product product;
  const CustomShopProductCard({super.key, required this.product});

  @override
  State<CustomShopProductCard> createState() => _CustomShopProductCardState();
}

class _CustomShopProductCardState extends State<CustomShopProductCard> {
  @override
  Widget build(BuildContext context) {
    bool isFavorite = AppData.wishlistItems.contains(widget.product);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.background, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() { // Note theke: setState[cite: 1]
                  AppData.toggleWishlist(widget.product);
                });
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.asset(
                  widget.product.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '৳${widget.product.price}',
                        style: TextStyles.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // AI theke: শপ স্ক্রিনের কার্ডে কার্ট আইকন। ন্যাভিগেশন বাদ দেওয়া হয়েছে।
                GestureDetector(
                  onTap: () {
                    AppData.addToCart(widget.product);

                    // AI theke: মেসেজ পপআপ
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${widget.product.name} added to cart!'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC8553D),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}