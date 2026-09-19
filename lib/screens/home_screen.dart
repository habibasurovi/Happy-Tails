
import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/data/cart_data.dart';
import 'package:happy_tails/widgets/home_header.dart';
import 'package:happy_tails/widgets/home_greeting.dart';
import 'package:happy_tails/widgets/home_search_bar.dart';
import 'package:happy_tails/widgets/promo_banner.dart';
import 'package:happy_tails/widgets/shop_by_pet.dart';
import 'package:happy_tails/widgets/happy_picks.dart';
import 'package:happy_tails/widgets/shop_product_card.dart';
import 'package:happy_tails/models/product.dart';

class HomeScreen extends StatefulWidget {
  final void Function(String category)? onPetCategoryTap;
  const HomeScreen({super.key, this.onPetCategoryTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String query = searchController.text.trim();
    List<Product> searchResults = HomeSearchBar.searchProducts(query);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              const SizedBox(height: 16),
              const HomeGreeting(),
              const SizedBox(height: 14),
              HomeSearchBar(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),
              if (query.isNotEmpty) ...[
                Text(
                  'Search Results (${searchResults.length})',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                if (searchResults.isEmpty)
                  const Center(child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text("No products found."),
                  ))
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return ShopProductCard(
                        product: searchResults[index],
                        onAddToCart: () {
                          AppData.addToCart(searchResults[index]);
                        },
                        onToggleFavorite: () {
                          setState(() {
                            AppData.toggleWishlist(searchResults[index]);
                          });
                        },
                      );
                    },
                  ),
              ] else ...[
                const PromoBanner(),
                const SizedBox(height: 20),
                ShopByPet(onCategoryTap: widget.onPetCategoryTap),
                const SizedBox(height: 20),
                const HappyPicks(),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}