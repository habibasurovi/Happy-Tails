import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

mixin ProfileActionsMixin on State<ProfileScreen> {
  Future<void> loadProfile() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );
  }

  void navigateTo(
      BuildContext context,
      Widget screen,
      ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}

class _ProfileScreenState extends State<ProfileScreen>
    with ProfileActionsMixin {
  bool isEditPressed = false;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 18),
                ProfileHeaderCard(
                  isPressed: isEditPressed,
                  onEdit: () {
                    setState(() {
                      isEditPressed = !isEditPressed;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Edit Profile selected'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ProfileMenuSection(
                  items: [
                    ProfileMenuData(
                      icon: Icons.location_on_rounded,
                      title: 'Saved Addresses',
                      subtitle: '2 addresses',
                      iconColor: AppColors.primary,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Saved Addresses'),
                          ),
                        );
                      },
                    ),
                    ProfileMenuData(
                      icon: Icons.settings_rounded,
                      title: 'Settings',
                      subtitle: 'Notifications and preferences',
                      iconColor: AppColors.primary,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Settings'),
                          ),
                        );
                      },
                    ),
                    ProfileMenuData(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: 'Help & Support',
                      subtitle: 'FAQs and assistance',
                      iconColor: AppColors.primary,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Help & Support'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ProfileMenuItem(
                  icon: Icons.logout_rounded,
                  title: 'Logout',
                  iconColor: AppColors.primary,
                  titleColor: AppColors.primary,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logout selected'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileHeaderCard extends StatelessWidget {
  final bool isPressed;
  final VoidCallback onEdit;

  const ProfileHeaderCard({
    super.key,
    required this.isPressed,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      height: 205,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isPressed
            ? AppColors.primary
            : const Color(0xFFE87961),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 5,
            bottom: 8,
            child: Icon(
              Icons.pets_rounded,
              size: 58,
              color: Colors.white.withOpacity(0.16),
            ),
          ),
          Positioned(
            left: 45,
            bottom: 25,
            child: Icon(
              Icons.pets_rounded,
              size: 38,
              color: Colors.white.withOpacity(0.13),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: TextButton(
              onPressed: onEdit,
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.20),
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Edit  ›',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 76,
                  height: 76,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile/profile_avatar.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Bella's Hooman",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'bella.hooman@paws.net',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
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

class ProfileMenuData {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  ProfileMenuData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });
}

class ProfileMenuSection extends StatelessWidget {
  final List<ProfileMenuData> items;

  const ProfileMenuSection({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++)
            ProfileMenuItem(
              icon: items[i].icon,
              title: items[i].title,
              subtitle: items[i].subtitle,
              iconColor: items[i].iconColor,
              onTap: items[i].onTap,
            ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color iconColor;
  final Color? titleColor;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.iconColor = AppColors.primary,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: titleColor ?? AppColors.primaryText,
                        letterSpacing: 0.1,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppColors.secondaryText,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.secondaryText,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}