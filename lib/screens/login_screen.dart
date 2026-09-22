import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';
import 'package:happy_tails/widgets/logo_section.dart';
import 'package:happy_tails/widgets/custom_text_field.dart';
import 'package:happy_tails/widgets/primary_button.dart';
import 'package:happy_tails/utils/form_validator.dart';
import 'package:happy_tails/screens/main_screen.dart';
import 'package:happy_tails/screens/signup_screen.dart';
import 'package:happy_tails/utils/auth_services.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthServices authServices = AuthServices();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  String? _emailError;
  String? _passwordError;
  @override void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  bool _validateFields()
  {
    setState((){
      _emailError = FormValidator.validateEmail(_emailController.text);
      _passwordError = FormValidator.validatePassword(_passwordController.text);
    });
    return _emailError == null && _passwordError == null;
  }
  void _handleLogin() async {
    if (_validateFields()) {
      try {
        await authServices.login(
          _emailController.text,
          _passwordController.text,
        );

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email or password'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    }
  }  
  @override
  Widget build(BuildContext context)
  {
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
                      Text(
                        'Welcome Back! 💛',
                        style: TextStyles.heading,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your paw-fect shopping buddy missed you',
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
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColors.secondaryText,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                activeColor: AppColors.primary,
                                onChanged: (value) => setState(() => _rememberMe = value ?? false),
                              ),
                              Text('Remember me', style: TextStyles.secondary),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              try {
                                await authServices.forgotPassword(
                                    _emailController.text);
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Password reset email sent!'),
                                  ),
                                );
                              } catch (e) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Enter a valid email.'),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyles.secondary.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      PrimaryButton(
                        label: 'Log In',
                        onPressed: _handleLogin,
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyles.secondary,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
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
        )
      )
    );
  }
}

