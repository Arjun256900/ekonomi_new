import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/bloc/Income_Onboard/IncomeBloc.dart';
import 'package:ekonomi_new/screens/Inocme_Onboard.dart';
import 'package:ekonomi_new/widgets/form_widgets/custom_text_field.dart';
import 'package:ekonomi_new/widgets/general/Onboard_Btn.dart';
import 'package:ekonomi_new/widgets/general/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Createaccount extends StatefulWidget {
  const Createaccount({super.key});

  @override
  State<Createaccount> createState() => _CreateaccountState();
}

class _CreateaccountState extends State<Createaccount> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              leading: BackButtonLeading(),
              title: const Text(
                "Sign Up",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    /// Heading
                    const Text(
                      "Create Your Account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Let’s get started with your secure financial account.",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),

                    const SizedBox(height: 30),

                    /// Full Name
                    CustomTextField(
                      controller: nameController,
                      heading: "Full Name",
                      hintText: "Enter your full name",
                      keyboardType: TextInputType.name,
                      onChanged: (_) {},
                    ),

                    const SizedBox(height: 20),

                    /// Email
                    CustomTextField(
                      controller: emailController,
                      heading: "Email Address",
                      hintText: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (_) {},
                    ),

                    const SizedBox(height: 20),

                    /// Password
                    CustomTextField(
                      controller: passwordController,
                      heading: "Password",
                      hintText: "Enter your password",
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                      onChanged: (_) {},
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "8+ characters, 1 uppercase, 1 number.",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),

                    const SizedBox(height: 30),

                    /// Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: OnboardBtn(
                        func: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<IncomeBloc>(),
                                child: const InocmeOnboard(),
                              ),
                            ),
                          );
                        },
                        caption: "Sign Up",
                        bgColor: Theme.of(context).primaryColor,
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// Terms
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: "By signing up, you agree to our ",
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: "Terms of Service",
                              style: TextStyle(color: Colors.teal),
                            ),
                            TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(color: Colors.teal),
                            ),
                            TextSpan(text: "."),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// OR Divider
                    Row(
                      children: const [
                        Expanded(child: Divider(color: Colors.grey)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "OR",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Google Button (UI only)
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.g_mobiledata, color: Colors.black),
                      label: const Text(
                        "Sign up with Google",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Apple Button
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.apple, color: Colors.black),
                      label: const Text(
                        "Sign up with Apple",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Footer
                    Center(
                      child: RichText(
                        text: const TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(color: Colors.teal),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
