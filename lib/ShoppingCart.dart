import 'package:flutter/material.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<Map<String, dynamic>> shoppingCart = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void addItem(String name, int quantity, double price) {
    setState(() {
      shoppingCart.add({'name': name, 'quantity': quantity, 'price': price});
    });
  }

  void removeItem(int index) {
    setState(() {
      shoppingCart.removeAt(index);
    });
  }

  void increaseQuantity(int index) {
    setState(() {
      shoppingCart[index]['quantity']++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (shoppingCart[index]['quantity'] > 1) {
        shoppingCart[index]['quantity']--;
      }
    });
  }

  double calculateTotal() {
    return shoppingCart.fold(
        0, (total, item) => total + (item['quantity'] * item['price']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('سلة المشتريات'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // إدخال بيانات العنصر
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'اسم العنصر'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'الكمية'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'السعر'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    quantityController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  addItem(
                    nameController.text,
                    int.parse(quantityController.text),
                    double.parse(priceController.text),
                  );
                  nameController.clear();
                  quantityController.clear();
                  priceController.clear();
                }
              },
              child: Text('إضافة إلى السلة'),
            ),
            SizedBox(height: 16),
            // عرض العناصر
            Expanded(
              child: ListView.builder(
                itemCount: shoppingCart.length,
                itemBuilder: (context, index) {
                  final item = shoppingCart[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text(
                          'الكمية: ${item['quantity']} - السعر: ${item['price']} ريال'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => decreaseQuantity(index),
                            icon: Icon(Icons.remove),
                          ),
                          IconButton(
                            onPressed: () => increaseQuantity(index),
                            icon: Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed: () => removeItem(index),
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // عرض إجمالي السعر
            Text(
              'الإجمالي: ${calculateTotal().toStringAsFixed(2)} ريال',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
