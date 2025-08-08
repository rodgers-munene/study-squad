import 'package:flutter/material.dart';
import 'package:studysquad/core/routes/app_routes.dart';
import 'package:studysquad/features/auth/services/auth_service.dart';
import 'package:studysquad/features/auth/widgets/auth_text_field.dart';

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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text("Login", style: Theme.of(context).textTheme.headlineLarge),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const SizedBox(height: 20),
                    const SizedBox(height: 10),
                    AuthTextField(
                      controller: _emailController,
                      label: "Email",
                      validator: (value) =>
                          value!.isEmpty ? "Email is required" : null,
                    ),
                    const SizedBox(height: 12),
                    Stack(
                      children: [
                        AuthTextField(
                          controller: _passwordController,
                          label: "Password",
                          obscureText: _hidePassword,
                          validator: (value) => value!.isEmpty
                              ? "Password is required"
                              : value.length < 6
                              ? "Password too short"
                              : null,
                        ),
                        Positioned(
                          right: 10,
                          child: _hidePassword
                              ? 
                              IconButton(
                                  onPressed: _toggleVisibility,
                                  icon: Icon(Icons.visibility_off_outlined),
                                )
                              : IconButton(
                                  onPressed: _toggleVisibility,
                                  icon: Icon(Icons.visibility_outlined),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _login,
                            child: const Text("Login"),
                          ),

                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.signup),
                      child: const Text("No account? Sign up"),
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
