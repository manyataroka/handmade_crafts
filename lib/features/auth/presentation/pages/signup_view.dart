import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:handmade_crafts/features/auth/data/repositories/auth_repository.dart';
import 'package:handmade_crafts/features/auth/data/models/auth_hive_model.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  bool isPasswordVisible = false;

  final TextEditingController usernameCtrl = TextEditingController();

  final TextEditingController emailCtrl = TextEditingController();

  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  String selectedCountryCode = '+977'; // default Nepal
  String? selectedGender;

  @override
  void dispose() {
    usernameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> register() async {
    final username = usernameCtrl.text.trim();
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text;
    final confirmPassword = confirmPasswordCtrl.text;
    final phone = phoneCtrl.text.trim();

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty ||
        selectedGender == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    final authRepo = ref.read(authRepositoryProvider);
    final user = AuthHiveModel(
      authId: const Uuid().v4(),
      email: email,
      password: password,
      fullName: username,
      username: username,
      phoneNumber: '${selectedCountryCode}${phone}',
      batchId: null,
      profilePicture: null,
    );

    final success = await authRepo.register(user, email: '');
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Registered successfully',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF5F5F5), Color(0xFFF8D7DA)],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// LOGO
                  Image.asset('assets/images/picture1.png', height: 100),

                  const SizedBox(height: 20),

                  /// TITLE
                  Column(
                    children: [
                      const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(height: 3, width: 70, color: Colors.red),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// USERNAME
                  TextField(
                    controller: usernameCtrl,
                    decoration: InputDecoration(
                      hintText: "Username",
                      prefixIcon: const Icon(Icons.person_outline),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// EMAIL
                  TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      prefixIcon: const Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const SizedBox(height: 15),

                  /// COUNTRY CODE + PHONE (moved into form)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String>(
                          value: selectedCountryCode,
                          underline: const SizedBox.shrink(),
                          items: const [
                            DropdownMenuItem(
                              value: '+977',
                              child: Text('+977 Nepal'),
                            ),
                            DropdownMenuItem(
                              value: '+86',
                              child: Text('+86 China'),
                            ),
                            DropdownMenuItem(
                              value: '+91',
                              child: Text('+91 India'),
                            ),
                            DropdownMenuItem(
                              value: '+92',
                              child: Text('+92 Pakistan'),
                            ),
                          ],
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              selectedCountryCode = v;
                            });
                          },
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: TextField(
                          controller: phoneCtrl,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            prefixIcon: const Icon(Icons.phone_outlined),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  /// GENDER (moved into form)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedGender,
                      hint: const Text('Select Gender'),
                      underline: const SizedBox.shrink(),
                      items: const [
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                        DropdownMenuItem(
                          value: 'Others',
                          child: Text('Others'),
                        ),
                      ],
                      onChanged: (v) {
                        setState(() {
                          selectedGender = v;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 15),

                  /// PASSWORD
                  TextField(
                    controller: passwordCtrl,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// CONFIRM PASSWORD
                  TextField(
                    controller: confirmPasswordCtrl,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// REGISTER BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: register,
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// LOGIN NAVIGATION
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
