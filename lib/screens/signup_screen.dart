import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';
import 'package:happy_tails/widgets/logo_section.dart';
import 'package:happy_tails/widgets/custom_text_field.dart';
import 'package:happy_tails/widgets/primary_button.dart';
import 'package:happy_tails/utils/form_validator.dart';
import 'package:happy_tails/utils/auth_services.dart';
import 'package:happy_tails/screens/main_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final AuthServices _authServices = AuthServices();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Reusable eye icon button for password fields
  Widget _buildEyeIcon(bool obscure, VoidCallback onTap) {
    return IconButton(
      icon: Icon(
        obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: AppColors.secondaryText,
      ),
      onPressed: onTap,
    );
  }

  bool _validateFields() {
    setState(() {
      _emailError = FormValidator.validateEmail(_emailController.text);
      _passwordError = FormValidator.validatePassword(_passwordController.text);
      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = 'Please confirm your password';
      } else if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = 'Passwords do not match';
      } else {
        _confirmPasswordError = null;
      }
    });
    return _emailError == null && _passwordError == null && _confirmPasswordError == null;
  }

  void _handleSignup() async {
    if (_validateFields()) {
      try {
        await _authServices.register(
          _emailController.text.trim(),
          _passwordController.text,
        );
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up failed. Please try again.'), backgroundColor: AppColors.primary),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LogoSection(),
              Card(
                margin: EdgeInsets.zero,
                elevation: 4,
                color: AppColors.background,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text('Create Account', style: TextStyles.heading),
                      const SizedBox(height: 4),
                      Text(
                        'Join the Happy Tails family today!',
                        style: TextStyles.secondary,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email Address',
                        hintText: 'hello@happytails.com',
                        prefixIcon: Icons.email_outlined,
                        errorText: _emailError,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hintText: '••••••••',
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        errorText: _passwordError,
                        suffixIcon: _buildEyeIcon(_obscurePassword,
                            () => setState(() => _obscurePassword = !_obscurePassword)),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        hintText: '••••••••',
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscureConfirm,
                        errorText: _confirmPasswordError,
                        suffixIcon: _buildEyeIcon(_obscureConfirm,
                            () => setState(() => _obscureConfirm = !_obscureConfirm)),
                      ),
                      const SizedBox(height: 28),
                      PrimaryButton(label: 'Sign Up', onPressed: _handleSignup),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account? ', style: TextStyles.secondary),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              'Log In',
                              style: TextStyles.secondary.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

