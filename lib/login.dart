import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'auth_service.dart';
import 'register.dart';
import 'home_screen.dart';
import 'forget_passsword.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true, // Set to true to extend the body behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Set the background color to transparent
        elevation: 0, // Remove app bar shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Lottie.asset(
                      'assets/images/coffeee.json',
                      width: 110,
                      height: 100,
                    ),
                    const SizedBox(width: 2),
                    const Text(
                      'Sign In.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          filled: true,
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 47, 25, 5),
                    ),
                    child: const Text('Forgot Password'),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text.trim();
                    String password = passwordController.text;

                    User? user = await authService.signInWithEmailAndPassword(email, password);

                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen(authService: authService)),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Login Failed'),
                          content: const Text('Invalid email or password. Please try again.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.brown,
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 74, 67, 7),
                      ),
                      child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
