import 'package:flutter/material.dart';
import 'package:flutter_final_project/Data/data.dart';
import 'package:flutter_final_project/Pages/ShoppingCart.dart'; // Ensure this imports your Product and ProductManager classes

class TeaScreen extends StatefulWidget {
  final BasketManager basketManager; // Pass BasketManager
  final ProductManager productManager;

  const TeaScreen(
      {Key? key, required this.basketManager, required this.productManager})
      : super(key: key);

  @override
  _TeaScreenState createState() => _TeaScreenState();
}

class _TeaScreenState extends State<TeaScreen> {
  late List<Product> products; // Declare products list
  String sortOrder = 'Lowest to Highest';
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    products = sampleTeas; // Use sample teas for initialization
  }

  @override
  Widget build(BuildContext context) {
    // Sort products based on price
    products.sort((a, b) => sortOrder == 'Lowest to Highest'
        ? a.price.compareTo(b.price)
        : b.price.compareTo(a.price));

    // Filter products based on search query
    List<Product> filteredProducts = products.where((product) {
      return searchQuery.isEmpty ||
          product.name.toLowerCase().startsWith(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: const Text(
          'Tea',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchField(),
            const SizedBox(height: 16),
            _buildSortButtons(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: filteredProducts.map((product) {
                  return TeaCard(
                    id: product.id,
                    image: product.image,
                    name: product.name,
                    price: '€${product.price.toStringAsFixed(2)}',
                    basketManager: widget.basketManager, // Pass BasketManager
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildSortButtons() {
    return Wrap(
      runSpacing: 8,
      children: [
        _buildFilterButton('Lowest to Highest', 'price'),
        const SizedBox(width: 10),
        _buildFilterButton('Highest to Lowest', 'price'),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: '', // Removed label
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '', // Removed label
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            // Navigate to ShoppingCartPage on tap
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShoppingCartPage(
                  basketManager: widget.basketManager,
                  productManager:
                      widget.productManager, // Include ProductManager
                ),
              ),
            );
          }
        });
  }

  Widget _buildFilterButton(String label, String filterType) {
    bool isSelected = sortOrder == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          sortOrder = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
          border: isSelected ? null : Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            if (isSelected) const Icon(Icons.check, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class TeaCard extends StatelessWidget {
  final String id;
  final String image;
  final String name;
  final String price;
  final BasketManager basketManager; // Accept BasketManager

  const TeaCard({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.basketManager, // Accept basket manager
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart, size: 30),
              onPressed: () {
                // Add or update the basket item
                basketManager.addOrUpdateBasketItem(
                    userId, id); // Ensure userId is defined
              },
            ),
          ),
        ],
      ),
    );
  }
}
