import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('order').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No orders found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot orderDoc = snapshot.data!.docs[index];
              final tableNumber = orderDoc['table'] ?? 'Unknown Table';
              final items = orderDoc['items'] ?? [];

              return Card(
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Table $tableNumber Order',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: items.map<Widget>((item) {
                          final itemName = item['name'] ?? 'Unknown Item';
                          final quantity = item['quantity'] ?? 0;
                          final price = item['price'] ?? 0.0;

                          return ListTile(
                            title: Text('$itemName x $quantity'),
                            subtitle: Text('\$$price'),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
