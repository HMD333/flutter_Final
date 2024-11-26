import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/Theme/theme_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_final_project/Data/data.dart';
import 'package:flutter_final_project/Pages/ShoppingCart.dart'; // Import your ShoppingCartPage

class HomePage extends StatefulWidget {
  final ProductManager productManager; // Pass ProductManager
  final BasketManager basketManager; // Pass BasketManager

  HomePage(
      {Key? key, required this.productManager, required this.basketManager})
      : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String _username = "";
  String _email = "";
  String _imgpath = "";
  late List<Map<String, dynamic>> categories;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredCategories = [];
  int _currentIndex = 0; // Track the current index for BottomNavigationBar

  @override
  void initState() {
    super.initState();
    themeManager.addListener(themeListener);
    _loadUserInfo();
    _initializeCategories();
  }

  void _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList('users') ?? [];
    for (var userString in users) {
      Map<String, dynamic> user = jsonDecode(userString);
      if (user['userId'] == userId) {
        setState(() {
          _username = user['userName'] ?? "Guest";
          _email = user['userEmail'] ?? "";
          _imgpath = user['userImage'] ?? "";
        });
      }
    }
  }

  void _initializeCategories() {
    // Ensure sample products are added to the passed productManager
    for (var product in sampleProducts) {
      widget.productManager.addProduct(product);
    }
    for (var product in sampleFruits) {
      widget.productManager.addProduct(product);
    }
    for (var product in sampleBreads) {
      widget.productManager.addProduct(product);
    }
    for (var product in sampleTeas) {
      widget.productManager.addProduct(product);
    }

    setState(() {
      categories = [
        {
          'title': 'Vegetables',
          'count': widget.productManager.getCountByCategory('Vegetable'),
          'image': 'images/Vegetables.jpg',
        },
        {
          'title': 'Fruits',
          'count': widget.productManager.getCountByCategory('Fruit'),
          'image': 'images/Fruits.jpg',
        },
        {
          'title': 'Bread',
          'count': widget.productManager.getCountByCategory('Bread'),
          'image': 'images/Bread.jpg',
        },
        {
          'title': 'Tea',
          'count': widget.productManager.getCountByCategory('Tea'),
          'image': 'images/Tea.jpg',
        },
      ];
      _filteredCategories = categories;
    });
  }

  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    _searchController.dispose();
    super.dispose();
  }

  void themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  void _filterCategories(String query) {
    setState(() {
      _filteredCategories = query.isEmpty
          ? categories
          : categories.where((category) {
              return category['title']
                  .toLowerCase()
                  .contains(query.toLowerCase());
            }).toList();
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Home'),
      ),
      drawer: _buildDrawer(_textTheme),
      body: _currentIndex == 0
          ? _buildHomeContent()
          : ShoppingCartPage(
              basketManager: widget.basketManager,
              productManager: widget.productManager),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped, // Handle tap events
      ),
    );
  }

  Widget _buildDrawer(TextTheme textTheme) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            accountName: Text(
              _username,
              style: textTheme.titleSmall?.copyWith(color: Colors.white),
            ),
            accountEmail: Text(
              _email,
              style: textTheme.titleSmall?.copyWith(color: Colors.white),
            ),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundImage:
                    _imgpath.isNotEmpty && File(_imgpath).existsSync()
                        ? FileImage(File(_imgpath))
                        : const NetworkImage('https://via.placeholder.com/150'),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushNamed(context, '/profile'); // Navigate to Profile
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            onChanged: _filterCategories,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              hintText: 'Search',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.7 / 3,
              ),
              itemCount: _filteredCategories.length,
              itemBuilder: (context, index) {
                final category = _filteredCategories[index];
                return CategoryCard(
                  title: category['title'],
                  count: category['count'],
                  imageUrl: category['image'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final int count;
  final String imageUrl;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.count,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/$title');
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              height: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$count items',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
