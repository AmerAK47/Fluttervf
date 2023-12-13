import 'package:flutter/material.dart';
import 'package:flutter_projectt/review.dart';
import 'package:flutter_projectt/table3.dart';
import 'package:flutter_projectt/table4.dart';
import 'package:flutter_projectt/table5.dart';
import 'auth_service.dart'; // Import your authentication service
import 'login.dart'; // Import the LoginScreen
import 'table1.dart'; // Import the Table 1 screen
import 'table2.dart'; // Import the Table 2 screen
// Import other table screens as needed

class HomeScreen extends StatelessWidget {
  final AuthService authService;

  const HomeScreen({Key? key, required this.authService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await authService.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Coffee Shop',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
              fontFamily: 'Pacifico',
              shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(20.0),
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              children: [
                buildTableButton(context, 'Table 1', 'assets/images/table.png', Table1Screen()),
                buildTableButton(context, 'Table 2', 'assets/images/table.png', Table2Screen()),
                buildTableButton(context, 'Table 3', 'assets/images/table.png', Table3Screen()),
                buildTableButton(context, 'Table 4', 'assets/images/table.png', Table4Screen()),
                buildTableButton(context, 'Table 5', 'assets/images/table.png', Table5Screen()),
                // Add more buttons for additional tables
              ],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReviewOrdersPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.brown,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.list_alt),
                const SizedBox(width: 8),
                Text('Review Orders'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTableButton(BuildContext context, String tableName, String imagePath, Widget screen) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 100, height: 100),
            const SizedBox(height: 5),
            Text(
              tableName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
