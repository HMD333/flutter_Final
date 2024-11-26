import 'package:flutter/material.dart';
import 'package:flutter_final_project/Data/data.dart'; // Ensure this path is correct

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late List<Product> products =
      sampleProducts + sampleFruits + sampleBreads + sampleTeas;

  List<Basket> get shoppingCart => basketManager.baskets;

  Product getProductById(String id) {
    return products.firstWhere((product) => product.id == id);
  }

  void removeItem(int index) {
    setState(() {
      basketManager.baskets.removeAt(index);
    });
  }

  void changeQuantity(int index, int delta) {
    setState(() {
      final newQuantity = basketManager.baskets[index].quantity + delta;
      if (newQuantity > 0) {
        basketManager.baskets[index].quantity = newQuantity;
      }
    });
  }

  double calculateTotal() {
    return shoppingCart.fold(
        0,
        (total, item) =>
            total + (item.quantity * getProductById(item.productId).price));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: shoppingCart.isEmpty
            ? Center(child: const Text('Cart is empty'))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: shoppingCart.length,
                      itemBuilder: (context, index) {
                        final item = shoppingCart[index];
                        final product = getProductById(item.productId);
                        return _buildCartItem(product, item, index);
                      },
                    ),
                  ),
                  _buildTotalPrice(),
                  const SizedBox(height: 16),
                  _buildCheckoutButton(context),
                ],
              ),
      ),
    );
  }

  Widget _buildCartItem(Product product, Basket item, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(product.name), // Assuming product has a name property
        subtitle: Text(
          'Quantity: ${item.quantity}\n'
          'Price: ${product.price.toStringAsFixed(2)} RS\n'
          'Total: ${(product.price * item.quantity).toStringAsFixed(2)} RS',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => changeQuantity(index, -1), // Decrease quantity
              icon: const Icon(Icons.remove),
            ),
            IconButton(
              onPressed: () => changeQuantity(index, 1), // Increase quantity
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () => removeItem(index),
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalPrice() {
    return Text(
      'Total: ${calculateTotal().toStringAsFixed(2)} RS',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        basketManager.Totel = calculateTotal();
        Navigator.pushReplacementNamed(context, '/Checkout');
      },
      child: const Text('Buy'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        textStyle: const TextStyle(fontSize: 18),
      ),
    );
  }
}
