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
  bool isEditing = false;

  String name = "Max";
  String email = "happy_tails@gmail.com...";
  String phone = "01826287698";

  String newName = '';
  String newEmail = '';
  String newPhone = '';

  String newAddress = '';

  List<String> savedAddresses = [
    'House 12, Road 5, Dhanmondi, Dhaka, Bangladesh',
  ];

  void saveProfile() {
    setState(() {
      if (newName.isNotEmpty) {
        name = newName;
      }

      if (newEmail.isNotEmpty) {
        email = newEmail;
      }
      if (newPhone.isNotEmpty) {
        phone = newPhone;
      }

      isEditing = false;
    });
  }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile Information',
                      style: TextStyles.subHeading,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (isEditing) {
                          saveProfile();
                        } else {
                          setState(() {
                            isEditing = true;
                            newName = name;
                            newEmail = email;
                            newPhone = phone;
                          });
                        }
                      },
                      child: Text(
                        isEditing ? 'Save' : 'Edit',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                if (isEditing)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    color: AppColors.textField,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: TextStyles.secondary,
                        ),

                        TextField(
                          onChanged: (value) {
                            newName = value;
                          },
                          decoration: InputDecoration(
                            hintText: name,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'Email',
                          style: TextStyles.secondary,
                        ),

                        TextField(
                          onChanged: (value) {
                            newEmail = value;
                          },
                          decoration: InputDecoration(
                            hintText: email,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'Phone',
                          style: TextStyles.secondary,
                        ),

                        TextField(
                          onChanged: (value) {
                            newPhone = value;
                          },
                          decoration: InputDecoration(
                            hintText: phone,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: AppColors.textField,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: $name',
                          style: TextStyles.body,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Email: $email',
                          style: TextStyles.secondary,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Phone: $phone',
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
                      child: const Text(
                        '+ Add Address',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                if (showAddressField)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    color: AppColors.textField,
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            newAddress = value;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter your address',
                          ),
                        ),

                        const SizedBox(height: 10),

                        ElevatedButton(
                          onPressed: addAddress,
                          child: const Text(
                            'Save Address',
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 10),

                Column(
                  children: [
                    for (String address in savedAddresses)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(bottom: 10),
                        color: AppColors.surface,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                            ),

                            const SizedBox(width: 10),

                            Text(
                              address,
                              style: TextStyles.body,
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
                  color: AppColors.card,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyles.button,
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