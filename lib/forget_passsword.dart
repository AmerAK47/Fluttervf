import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'auth_service.dart'; // Import your authentication service
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Set background color to transparent
        elevation: 0.0, // Set elevation to 0.0 to remove the shadow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200, // Adjust the width as needed
                  height: 200, // Adjust the height as needed
                  child: Lottie.asset(
                    'assets/images/fille.json', // Replace with the path to your Lottie animation
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text.trim();

                    if (email.isEmpty) {
                      // Show an error message if the email is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter your email.'),
                          backgroundColor: Color.fromARGB(255, 197, 161, 42), // Set the background color to red
                        ),
                      );
                    } else {
                      // Continue with password reset if the email is not empty
                      await authService.resetPassword(email);

                      // Show a confirmation message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password reset email sent. Check your email inbox.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.brown,
                  ),
                  child: const Text('Reset Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
