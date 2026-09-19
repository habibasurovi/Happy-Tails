import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';
import 'package:happy_tails/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showAddressField = false;

  String newAddress = '';

  List<String> savedAddresses = [
    'House 12, Road 5, Dhanmondi, Dhaka, Bangladesh',
  ];

  void addAddress() {
    if (newAddress.isNotEmpty) {
      setState(() {
        savedAddresses.add(newAddress);
        newAddress = '';
        showAddressField = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: TextStyles.heading,
                ),

                const SizedBox(height: 20),

                Center(
                  child: Column(
                    children: [

                      const SizedBox(height: 12),

                      Text(
                        "Bella's Hooman",
                        style: TextStyles.subHeading,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'bella.hooman@paws.net',
                        style: TextStyles.secondary,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Text(
                  'Profile Information',
                  style: TextStyles.subHeading,
                ),

                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: Bella's Hooman",
                        style: TextStyles.body,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Email: bella.hooman@paws.net',
                        style: TextStyles.secondary,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Phone: 01826287698',
                        style: TextStyles.secondary,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Saved Addresses',
                      style: TextStyles.subHeading,
                    ),

                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showAddressField = !showAddressField;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      ),
                      child: const Text(
                        '+ Add Address',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                if (showAddressField)
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: AppColors.textField,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            newAddress = value;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter your address',
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 10),

                        ElevatedButton(
                          onPressed: addAddress,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                          ),
                          child: const Text(
                            'Save Address',
                          ),
                        ),
                      ],
                    ),
                  ),

                Column(
                  children: [
                    for (String address in savedAddresses)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                address,
                                style: TextStyles.body,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 15),

                Text(
                  'Help & Support',
                  style: TextStyles.subHeading,
                ),

                const SizedBox(height: 8),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Welcome to Happy Tails Help & Support. '
                        'If you have any problem while using the app, '
                        'you can check your profile, saved addresses, '
                        'shopping cart and orders. For any further help, '
                        'please contact our support team. We are always '
                        'happy to help you and make your shopping experience '
                        'simple and comfortable.',
                    style: TextStyles.secondary,
                  ),
                ),

                const SizedBox(height: 25),

                Center(
                  child: SizedBox(
                    width: 150,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyles.button,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}