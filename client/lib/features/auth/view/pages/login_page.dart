import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/view/widget/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import '../widget/textformfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  bool checkboxValue = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fromKey.currentState!.validate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: fromKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up.',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(height: 15),
              CustomTextFormField(
                hintText: 'Email',
                controller: emailController,
              ),
              SizedBox(height: 15),
              CustomTextFormField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: checkboxValue,
              ),
              SizedBox(height: 15),
              AuthGradiantButton(text: 'Sign Up'),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.topLeft,
                child: Checkbox(
                    value: checkboxValue,
                    onChanged: (bool? value) {
                      setState(() {
                        checkboxValue = value ?? true;
                      });
                    }),
              ),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account?',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Pallete.gradient2,
                      ),
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
