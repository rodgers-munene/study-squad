import 'package:flutter/material.dart';
import 'package:studysquad/core/routes/app_routes.dart';
import 'package:studysquad/features/auth/services/auth_service.dart';
import 'package:studysquad/features/auth/widgets/auth_background.dart';
import 'package:studysquad/features/auth/widgets/auth_title.dart';
import 'package:studysquad/features/auth/widgets/login_signup_navigator.dart';
import 'package:studysquad/features/auth/widgets/password_field.dart';
import 'package:studysquad/features/auth/widgets/remember_forget.dart';
import 'package:studysquad/features/auth/widgets/separator.dart';
import 'package:studysquad/features/auth/widgets/social_logins.dart';
import 'package:studysquad/features/auth/widgets/text_field_input.dart';
import 'package:studysquad/widgets/loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _hidePassword = true;

// prevent memory leaks
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });

    final result = await AuthService().loginWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (result == "success") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login Successful")));
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: AuthBackground(
          child: Column(
            children: [
              AuthTitle(title: "Welcome Back"),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    SocialLogins(),
                    const SizedBox(height: 20),
                    Separator(),
                    const SizedBox(height: 20),
                    TextFieldInput(controller: _emailController),
                    const SizedBox(height: 20),
                    PasswordField(
                      controller: _passwordController,
                      hidePassword: _hidePassword,
                      toggleVisibility: _toggleVisibility,
                    ),
                    RememberForget(),
                    const SizedBox(height: 20),
                    LoadingButton(isLoading: _isLoading, onPressed: _login, text: "Login"),
                    LoginSignupNavigator(
                      txt1: "Don't have an account?",
                      txt2: "Sign Up.",
                      route: AppRoutes.signup,
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
