import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';
import 'package:happy_tails/data/cat_products.dart';
import 'package:happy_tails/models/product.dart';
import 'package:happy_tails/widgets/home_search_bar.dart';
import 'package:happy_tails/widgets/shop_product_card.dart';

class ShopScreen extends StatefulWidget {
  final String initialCategory;
  const ShopScreen({super.key, this.initialCategory = 'Dogs'});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final TextEditingController searchController = TextEditingController();

  late String selectedMainCategory;
  String selectedSubCategory = 'Food';
  String selectedNestedCategory = 'All';
  String selectedSort = 'Popular';

  final List<Map<String, String>> mainCategories = [
    {'name': 'Dogs', 'icon': '🐶'},
    {'name': 'Cats', 'icon': '🐱'},
    {'name': 'Birds', 'icon': '🐦'},
    {'name': 'Bunnies', 'icon': '🐰'},
    {'name': 'Fish', 'icon': '🐟'},
  ];

  final Map<String, List<String>> subCategoriesByPet = {
    'Dogs': ['All', 'Food', 'Toys', 'Accessories', 'Grooming'],
    'Cats': ['All', 'Food', 'Kitten', 'Toys', 'Accessories', 'Litter'],
    'Birds': ['All', 'Food', 'Toys', 'Cage & Accessories', 'Health'],
    'Bunnies': ['All', 'Food', 'Toys', 'Cage & Accessories', 'Health'],
    'Fish': ['All', 'Food', 'Tanks & Accessories', 'Filters', 'Decorations'],
  };

  final List<String> foodSubSections = [
    'All',
    'Wet Food',
    'Dry Food',
    'Can Food',
  ];

  final List<String> kittenSubSections = [
    'All',
    'Dry Food',
    'Wet Food',
    'Milk',
    'Feeder',
  ];

  List<String> get currentSubCategories =>
      subCategoriesByPet[selectedMainCategory] ?? ['All'];

  @override
  void initState() {
    super.initState();
    selectedMainCategory = widget.initialCategory;
    searchController.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(ShopScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialCategory != widget.initialCategory) {
      setState(() {
        selectedMainCategory = widget.initialCategory;
        selectedSubCategory = 'All';
        selectedNestedCategory = 'All';
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Product> get filteredProducts {
    List<Product> results = catProductsData.where((product) {
      if (product.mainCategory != selectedMainCategory) return false;
      if (selectedSubCategory != 'All' && product.subCategory != selectedSubCategory) return false;
      if (selectedNestedCategory != 'All' && product.nestedCategory != selectedNestedCategory) return false;
      if (searchController.text.isNotEmpty) {
        final query = searchController.text.toLowerCase();
        if (!product.name.toLowerCase().contains(query) &&
            !product.subCategory.toLowerCase().contains(query)) return false;
      }
      return true;
    }).toList();

    // Apply sort
    switch (selectedSort) {
      case 'Price: Low to High':
        results.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        results.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Rating':
        results.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
        break;
      default:
        break;
    }
    return results;
  }

  List<String> get currentNestedSubSections {
    if (selectedMainCategory == 'Cats' && selectedSubCategory == 'Food') return foodSubSections;
    if (selectedMainCategory == 'Cats' && selectedSubCategory == 'Kitten') return kittenSubSections;
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final products = filteredProducts;
    final hasNested = currentNestedSubSections.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Header + Search ──────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shop',
                          style: TextStyles.appTitle.copyWith(
                            color: AppColors.primaryText,
                            fontSize: 28,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.tune,
                            color: AppColors.primaryText,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    HomeSearchBar(controller: searchController),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),

            // ── Main Category Chips (Dogs, Cats, Birds, Bunnies) ─────────
            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: mainCategories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final category = mainCategories[index];
                    final isSelected = selectedMainCategory == category['name'];
                    return GestureDetector(
                      onTap: () => setState(() {
                        selectedMainCategory = category['name']!;
                        selectedSubCategory = 'All';
                        selectedNestedCategory = 'All';
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(category['icon']!, style: const TextStyle(fontSize: 15)),
                            const SizedBox(width: 6),
                            Text(
                              category['name']!,
                              style: TextStyles.body.copyWith(
                                color: isSelected ? AppColors.white : AppColors.primaryText,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // ── Sub-category Chips (All, Food, Kitten, Toys …) ───────────
            SliverToBoxAdapter(
              child: SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: currentSubCategories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = currentSubCategories[index];
                    final isSelected = selectedSubCategory == category;
                    return GestureDetector(
                      onTap: () => setState(() {
                        selectedSubCategory = category;
                        selectedNestedCategory = 'All';
                      }),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withValues(alpha: 0.15)
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border.withValues(alpha: 0.5),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          category,
                          style: TextStyles.body.copyWith(
                            color: isSelected ? AppColors.primary : AppColors.secondaryText,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ── Nested Sub-section Chips (Wet Food / Dry Food …) ─────────
            if (hasNested) ...[
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 34,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    physics: const BouncingScrollPhysics(),
                    itemCount: currentNestedSubSections.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final nestedCat = currentNestedSubSections[index];
                      final isSelected = selectedNestedCategory == nestedCat;
                      return GestureDetector(
                        onTap: () => setState(() => selectedNestedCategory = nestedCat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : AppColors.textField,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            nestedCat,
                            style: TextStyles.body.copyWith(
                              color: isSelected ? AppColors.white : AppColors.primaryText,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // ── Products Count & Sort ─────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${products.length} products',
                      style: TextStyles.secondary.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text('Sort: ', style: TextStyles.secondary.copyWith(fontSize: 12)),
                        DropdownButton<String>(
                          value: selectedSort,
                          isDense: true,
                          underline: const SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.primaryText),
                          style: TextStyles.body.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                          items: ['Popular', 'Price: Low to High', 'Price: High to Low', 'Rating']
                              .map((sort) => DropdownMenuItem(value: sort, child: Text(sort)))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => selectedSort = val);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // ── Product Grid ──────────────────────────────────────────────
            products.isEmpty
                ? SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search_off_rounded, size: 48, color: AppColors.secondaryText),
                          const SizedBox(height: 8),
                          Text(
                            'No products found in this category',
                            style: TextStyles.body.copyWith(color: AppColors.secondaryText),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ShopProductCard(product: products[index]),
                        childCount: products.length,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
