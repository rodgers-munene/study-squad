import 'package:flutter/material.dart';
import 'package:studysquad/core/routes/app_routes.dart';
import 'package:studysquad/features/auth/services/auth_service.dart';
import 'package:studysquad/features/auth/widgets/auth_background.dart';
import 'package:studysquad/features/auth/widgets/auth_text_field.dart';
import 'package:studysquad/features/auth/widgets/login_signup_navigator.dart';
import 'package:studysquad/features/auth/widgets/password_field.dart';
import 'package:studysquad/features/auth/widgets/remember_forget.dart';
import 'package:studysquad/features/auth/widgets/social_logins.dart';
import 'package:studysquad/features/auth/widgets/text_field_input.dart';
import 'package:studysquad/themes/themes.dart';

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

    setState(() {
      _isLoading = false;
    });

    if (result == "success") {
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
      resizeToAvoidBottomInset: false,
      body: AuthBackground(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text("Login", style: Theme.of(context).textTheme.headlineLarge),
            SingleChildScrollView(
              
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 15,),
                    SocialLogins(),
                    const SizedBox(height: 10,),
                    TextFieldInput(controller: _emailController),
                    const SizedBox(height: 20,),
                    PasswordField(controller: _passwordController, hidePassword: _hidePassword, toggleVisibility: _toggleVisibility),
                    RememberForget(),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _login,
                            child: const Text("Login"),
                          ),
                    LoginSignupNavigator(txt1: "Don't have an account?", txt2: "Sign Up.", route: AppRoutes.signup)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
