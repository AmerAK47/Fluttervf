import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'auth_service.dart';
import 'login.dart';
import 'home_screen.dart';
import 'welcome_screen.dart';
// Import the menu page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        title: 'Flutter Project',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 151, 145, 142),
        ),
        initialRoute: '/welcome',
        routes: {
          '/welcome': (context) => const WelcomeScreen(),
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreen(authService: Provider.of<AuthService>(context)),
         /* '/menu': (context) => const MenuPage(), // Add route for the MenuPage*/
        },
      ),
    ),
  );
}
