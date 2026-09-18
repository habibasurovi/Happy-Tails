import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/widgets/home_header.dart';
import 'package:happy_tails/widgets/home_greeting.dart';
import 'package:happy_tails/widgets/home_search_bar.dart';
import 'package:happy_tails/widgets/promo_banner.dart';
import 'package:happy_tails/widgets/shop_by_pet.dart';
import 'package:happy_tails/widgets/happy_picks.dart';
import 'package:happy_tails/widgets/home_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ওপরের লাভ আইকন রিমুভ করে শুধু ক্লিন হেডার রাখা হলো
              const HomeHeader(),
              const SizedBox(height: 16),
              const HomeGreeting(),
              const SizedBox(height: 14),
              HomeSearchBar(controller: searchController),
              const SizedBox(height: 16),
              const PromoBanner(),
              const SizedBox(height: 20),
              const ShopByPet(),
              const SizedBox(height: 20),
              const HappyPicks(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}