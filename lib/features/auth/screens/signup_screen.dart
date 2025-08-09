// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:studysquad/core/routes/app_routes.dart';
import 'package:studysquad/features/auth/services/auth_service.dart';
import 'package:studysquad/features/auth/widgets/auth_background.dart';
import 'package:studysquad/features/auth/widgets/auth_title.dart';
import 'package:studysquad/features/auth/widgets/login_signup_navigator.dart';
import 'package:studysquad/features/auth/widgets/password_field.dart';
import 'package:studysquad/features/auth/widgets/separator.dart';
import 'package:studysquad/features/auth/widgets/social_logins.dart';
import 'package:studysquad/features/auth/widgets/text_field_input.dart';
import 'package:studysquad/widgets/loading_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  String? _passwordError; // For real-time match check

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fix password mismatch")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final result = await AuthService().signUpWithEmail(
      _usernameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (result == "success") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Registration Successful")));
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AuthBackground(
          child: Column(
            children: [
              const AuthTitle(title: "Create Account"),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    const SocialLogins(),
                    const SizedBox(height: 10),
                    const Separator(),
                    const SizedBox(height: 10),

                    // Username
                    TextFieldInput(
                      controller: _usernameController,
                      label: "Username",
                    ),
                    const SizedBox(height: 10),

                    // Email
                    TextFieldInput(controller: _emailController),
                    const SizedBox(height: 10),

                    // Password
                    PasswordField(
                      controller: _passwordController,
                      hidePassword: _hidePassword,
                      toggleVisibility: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                    ),
                    const SizedBox(height: 10),

                    // Confirm Password
                    PasswordField(
                      controller: _confirmPassController,
                      hidePassword: _hideConfirmPassword,
                      label: "Confirm Password",
                      toggleVisibility: () {
                        setState(() {
                          _hideConfirmPassword = !_hideConfirmPassword;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    LoadingButton(isLoading: _isLoading, onPressed: _register, text: "Sign up"),
                    const SizedBox(height: 10),
                    LoginSignupNavigator(
                      txt1: "Already have an account?",
                      txt2: "Log In.",
                      route: AppRoutes.login,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
