import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool agree = false;

  void register() {

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );

      return;
    }

    if (!emailController.text.contains("@")) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email"),
        ),
      );

      return;
    }

    if (passwordController.text.length < 6) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password must be at least 6 characters"),
        ),
      );

      return;
    }

    if (passwordController.text != confirmPasswordController.text) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
        ),
      );

      return;
    }

    if (!agree) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please accept the Terms & Conditions",
          ),
        ),
      );

      return;
    }

    showDialog(

      context: context,

      builder: (_) => AlertDialog(

        title: const Text("Registration Successful"),

        content: const Text(
          "Welcome to StockMart! Your account has been created successfully.",
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(context);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const DashboardScreen(),
                ),
              );

            },

            child: const Text("Continue"),

          ),

        ],

      ),

    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: SafeArea(

            child: SingleChildScrollView(

              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 30,
              ),

              child: Column(

                children: [

                Image.asset(
                "assets/images/logo.png",
                width: 90,
              ),

              const SizedBox(height: 20),

              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Start your investing journey today.",
                style: TextStyle(
                  color: Colors.grey.shade400,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [

                  Icon(
                    Icons.verified,
                    color: Colors.green,
                    size: 18,
                  ),

                  SizedBox(width: 8),

                  Text(
                    "Trusted by thousands of investors",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 40),

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  filled: true,
                  fillColor: const Color(0xff12182B),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  filled: true,
                  fillColor: const Color(0xff12182B),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: const Color(0xff12182B),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  filled: true,
                  fillColor: const Color(0xff12182B),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),
                  CheckboxListTile(

                    value: agree,

                    activeColor: const Color(0xff4A9BFF),

                    contentPadding: EdgeInsets.zero,

                    controlAffinity: ListTileControlAffinity.leading,

                    onChanged: (value) {

                      setState(() {

                        agree = value!;

                      });

                    },

                    title: const Text(

                      "I agree to the Terms & Conditions",

                      style: TextStyle(
                        fontSize: 14,
                      ),

                    ),

                  ),

                  const SizedBox(height: 20),

                  SizedBox(

                    width: double.infinity,
                    height: 60,

                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(

                        backgroundColor: const Color(0xff4A9BFF),

                        shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(18),

                        ),

                      ),

                      onPressed: register,

                      child: const Text(

                        "Create Account",

                        style: TextStyle(

                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,

                        ),

                      ),

                    ),

                  ),

                  const SizedBox(height: 30),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      const Text(

                        "Already have an account?",

                      ),

                      TextButton(

                        onPressed: () {

                          Navigator.pop(context);

                        },

                        child: const Text(

                          "Sign In",

                        ),

                      ),

                    ],

                  ),

                ],

              ),

            ),

        ),

    );

  }

}