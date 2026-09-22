import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/widgets/home_search_bar.dart';
import 'package:happy_tails/models/product.dart';
import 'package:happy_tails/data/cart_data.dart';
import 'package:happy_tails/constants/text_styles.dart';
import 'package:happy_tails/widgets/shop_product_card.dart';
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
    String query = searchController.text.trim();
    
    // Search within the selected category.
    List<Product> filteredProducts = HomeSearchBar.searchProducts(query, category: selectedCategory);

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
            child: HomeSearchBar(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
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
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.card,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? AppColors.white : AppColors.secondaryText,
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
                return ShopProductCard(
                  product: filteredProducts[index],
                  onAddToCart: () {
                    AppData.addToCart(filteredProducts[index]);
                  },
                  onToggleFavorite: () {
                    setState(() {
                      AppData.toggleWishlist(filteredProducts[index]);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

