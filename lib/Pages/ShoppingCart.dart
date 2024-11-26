import 'package:flutter/material.dart';
import 'package:flutter_final_project/Data/data.dart'; // Ensure this path is correct

class ShoppingCartPage extends StatefulWidget {
  final BasketManager basketManager; // Reference to BasketManager
  final ProductManager productManager; // Reference to ProductManager

  ShoppingCartPage(
      {Key? key, required this.basketManager, required this.productManager})
      : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late List<Product> products =
      sampleProducts + sampleFruits + sampleBreads + sampleTeas;
  List<Basket> get shoppingCart => widget.basketManager.baskets;

  Product getProductById(String id) {
    return products.firstWhere((product) => product.id == id);
  }

  void removeItem(int index) {
    setState(() {
      widget.basketManager.baskets.removeAt(index);
    });
  }

  void increaseQuantity(int index) {
    setState(() {
      widget.basketManager.baskets[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (widget.basketManager.baskets[index].quantity > 1) {
        widget.basketManager.baskets[index].quantity--;
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
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(product
                                .name), // Assuming product has a name property
                            subtitle: Text(
                              '''Quantity: ${item.quantity}
                               Price: ${product.price.toStringAsFixed(2)} RS
                               Total: ${(product.price * item.quantity).toStringAsFixed(2)} RS''',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => decreaseQuantity(index),
                                  icon: const Icon(Icons.remove),
                                ),
                                IconButton(
                                  onPressed: () => increaseQuantity(index),
                                  icon: const Icon(Icons.add),
                                ),
                                IconButton(
                                  onPressed: () => removeItem(index),
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
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
                    'Totel: ${calculateTotal().toStringAsFixed(2)} RS',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/Checkout');
                    },
                    child: const Text('Buy'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
