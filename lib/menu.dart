import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<Map<String, dynamic>> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('menu').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No items found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot menuDoc = snapshot.data!.docs[index];
              final itemName = menuDoc['name'] ?? 'No name';
              dynamic itemPrice = menuDoc['price'];

              if (itemPrice is String) {
                itemPrice = double.tryParse(itemPrice) ?? 'Price not available';
              } else if (itemPrice is num) {
                itemPrice = itemPrice.toDouble();
              } else {
                itemPrice = 'Price not available';
              }

              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(itemName),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              selectedItems.add({'name': itemName, 'quantity': 1, 'price': itemPrice});
                            });
                          },
                        ),
                        Text(selectedItems.where((item) => item['name'] == itemName).length.toString()),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              selectedItems.removeWhere((item) => item['name'] == itemName);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                subtitle: Text('\$$itemPrice'),
              );
            },
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pop(context, selectedItems);
        },
        child: Text('Show Selected Items'),
      ),
    );
  }
}
