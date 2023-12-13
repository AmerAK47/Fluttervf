import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'menu.dart';

class Table2Screen extends StatefulWidget {
  @override
  _Table2ScreenState createState() => _Table2ScreenState();
}

class _Table2ScreenState extends State<Table2Screen> {
  List<Map<String, dynamic>> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table 2'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Orders',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );

                if (result != null && result is List<Map<String, dynamic>>) {
                  setState(() {
                    updateSelectedItems(result);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.brown,
              ),
              child: Text('Select Items'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: selectedItems.length,
                itemBuilder: (context, index) {
                  final itemName = selectedItems[index]['name'];
                  final itemQuantity = selectedItems[index]['quantity'];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(itemName ?? ''),
                      subtitle: Text('Quantity: ${itemQuantity ?? ''}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (itemQuantity != null && itemQuantity > 1) {
                                  selectedItems[index]['quantity'] = itemQuantity - 1;
                                } else {
                                  selectedItems.removeAt(index);
                                }
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                selectedItems.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                processOrder();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.brown,
              ),
              child: Text('Process Order'),
            ),
          ],
        ),
      ),
    );
  }

  void updateSelectedItems(List<Map<String, dynamic>> newItems) {
    for (final item in newItems) {
      final itemName = item['name'];
      final itemQuantity = item['quantity'];

      if (itemName != null && itemQuantity != null) {
        final existingItem = selectedItems.firstWhere(
              (selected) => selected['name'] == itemName,
          orElse: () => {'name': '', 'quantity': 0},
        );

        if (existingItem['name'] == itemName) {
          existingItem['quantity'] += itemQuantity;
        } else {
          selectedItems.add(item);
        }
      }
    }
  }

  void processOrder() async {
    try {
      final orderData = selectedItems.map((item) {
        return {
          'name': item['name'],
          'quantity': item['quantity'],
          'price': item['price'],
        };
      }).toList();

      await FirebaseFirestore.instance.collection('order').doc('t2orders').set({
        'table': 'Table 2',
        'items': orderData,
      });

      setState(() {
        selectedItems.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order processed successfully!'),
        ),
      );
    } catch (error) {
      print('Error processing order: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to process order.'),
        ),
      );
    }
  }
}
