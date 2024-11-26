library;

import 'package:uuid/uuid.dart';

String userId = '';

/// Class representing a Basket
class Basket {
  final String id; // Unique identifier for the basket entry
  final String userId; // User ID associated with the basket
  final String productId; // Product ID added to the basket
  int quantity;
  Basket(
      {required this.id,
      required this.userId,
      required this.productId,
      this.quantity = 1});

  /// Convert a Basket object to a Map for saving
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'quantity': quantity
    };
  }

  /// Create a Basket object from a Map
  factory Basket.fromMap(Map<String, dynamic> map) {
    return Basket(
        id: map['id'],
        userId: map['userId'],
        productId: map['productId'],
        quantity: map['quantity']);
  }
}

class BasketManager {
  List<Basket> baskets = []; // List to hold basket items

  // Method to add or update a basket item
  void addOrUpdateBasketItem(String userId, String productId) {
    // Check if the item already exists
    final existingBasketItemIndex = baskets.indexWhere(
      (basket) => basket.userId == userId && basket.productId == productId,
    );

    if (existingBasketItemIndex != -1) {
      // Increment quantity if the item exists
      baskets[existingBasketItemIndex].quantity++;
    } else {
      // Create a new basket item if it doesn't exist
      Basket newBasketItem = Basket(
        id: Uuid().v4(),
        userId: userId,
        productId: productId,
      );
      baskets.add(newBasketItem);
    }
  }

  // Method to display current basket items (for debugging)
  void displayBaskets() {
    for (var basket in baskets) {
      print(
          'User: ${basket.userId}, Product: ${basket.productId}, Quantity: ${basket.quantity}');
    }
  }
}

/// Class representing a Product
class Product {
  final String id;
  final String category;
  final String image;
  final String name;
  final double price;
  final String color;

  Product({
    required this.id,
    required this.category,
    required this.image,
    required this.name,
    required this.price,
    required this.color,
  });

  /// Convert a Product object to a Map for saving
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'image': image,
      'name': name,
      'price': price,
      'color': color,
    };
  }

  /// Create a Product object from a Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      category: map['category'],
      image: map['image'],
      name: map['name'],
      price: map['price'],
      color: map['color'],
    );
  }
}

/// Class to manage Products and their storage
class ProductManager {
  List<Product> products = []; // List of products

  /// Get all products by category
  List<Product> getAllProductsByCategory(String category) {
    return products
        .where((product) =>
            product.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  /// Get the count of products by category
  int getCountByCategory(String category) {
    return getAllProductsByCategory(category).length;
  }

  int getCountproducts() {
    return products.length;
  }

  /// Add a product to the list
  void addProduct(Product product) {
    products.add(product);
  }
}

/// Sample data initialization
List<Product> sampleProducts = [
  Product(
      id: Uuid().v4(),
      category: 'Vegetable',
      image: 'images/purple_cauliflower.jpg',
      name: 'Purple Cauliflower',
      price: 1.85,
      color: 'Purple'),
  Product(
      id: Uuid().v4(),
      category: 'Vegetable',
      image: 'images/savoy_cabbage.jpg',
      name: 'Savoy Cabbage',
      price: 1.45,
      color: 'Green'),
  Product(
      id: Uuid().v4(),
      category: 'Vegetable',
      image: 'images/carrot.jpg',
      name: 'Carrot',
      price: 0.80,
      color: 'Orange'),
  Product(
      id: Uuid().v4(),
      category: 'Vegetable',
      image: 'images/red_pepper.jpg',
      name: 'Red Pepper',
      price: 2.00,
      color: 'Red'),
  Product(
      id: Uuid().v4(),
      category: 'Vegetable',
      image: 'images/lettuce.jpg',
      name: 'Lettuce',
      price: 1.20,
      color: 'Green'),
  Product(
      id: Uuid().v4(),
      category: 'Vegetable',
      image: 'images/tomato.jpg',
      name: 'Tomato',
      price: 1.50,
      color: 'Red'),
  Product(
      id: Uuid().v4(),
      category: 'Vegetable',
      image: 'images/cucumber.jpg',
      name: 'Cucumber',
      price: 0.70,
      color: 'Green'),
  Product(
      id: Uuid().v4(),
      category: 'Vegetable',
      image: 'images/zucchini.jpg',
      name: 'Zucchini',
      price: 1.30,
      color: 'Green'),
  Product(
      id: Uuid().v4(),
      category: 'Vegetable',
      image: 'images/broccoli.jpg',
      name: 'Broccoli',
      price: 2.20,
      color: 'Green'),
  Product(
      id: Uuid().v4(),
      category: 'Vegetable',
      image: 'images/eggplant.jpg',
      name: 'Eggplant',
      price: 1.75,
      color: 'Purple'),
];

// Sample data for fruits, breads, and teas
List<Product> sampleFruits = [
  Product(
      id: Uuid().v4(),
      category: 'Fruit',
      image: 'images/apple.jpg',
      name: 'Apple',
      price: 1.00,
      color: 'Red'),
  Product(
      id: Uuid().v4(),
      category: 'Fruit',
      image: 'images/banana.jpg',
      name: 'Banana',
      price: 0.50,
      color: 'Yellow'),
  Product(
      id: Uuid().v4(),
      category: 'Fruit',
      image: 'images/orange.jpg',
      name: 'Orange',
      price: 0.75,
      color: 'Orange'),
  Product(
      id: Uuid().v4(),
      category: 'Fruit',
      image: 'images/grape.jpg',
      name: 'Grape',
      price: 2.00,
      color: 'Purple'),
  Product(
      id: Uuid().v4(),
      category: 'Fruit',
      image: 'images/strawberry.jpg',
      name: 'Strawberry',
      price: 1.50,
      color: 'Red'),
  Product(
      id: Uuid().v4(),
      category: 'Fruit',
      image: 'images/watermelon.jpg',
      name: 'Watermelon',
      price: 3.00,
      color: 'Green'),
  Product(
      id: Uuid().v4(),
      category: 'Fruit',
      image: 'images/kiwi.jpg',
      name: 'Kiwi',
      price: 1.20,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Fruit',
      image: 'images/pineapple.jpg',
      name: 'Pineapple',
      price: 2.50,
      color: 'Yellow'),
  Product(
      id: Uuid().v4(),
      category: 'Fruit',
      image: 'images/peach.jpg',
      name: 'Peach',
      price: 1.80,
      color: 'Yellow'),
  Product(
      id: Uuid().v4(),
      category: 'Fruit',
      image: 'images/blueberry.jpg',
      name: 'Blueberry',
      price: 2.20,
      color: 'Blue'),
];

List<Product> sampleBreads = [
  Product(
      id: Uuid().v4(),
      category: 'Bread',
      image: 'images/white_bread.jpg',
      name: 'White Bread',
      price: 1.00,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Bread',
      image: 'images/whole_wheat_bread.jpg',
      name: 'Whole Wheat Bread',
      price: 1.50,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Bread',
      image: 'images/sourdough_bread.jpg',
      name: 'Sourdough Bread',
      price: 2.00,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Bread',
      image: 'images/french_bread.jpg',
      name: 'French Bread',
      price: 1.75,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Bread',
      image: 'images/baguette.jpg',
      name: 'Baguette',
      price: 1.25,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Bread',
      image: 'images/rye_bread.jpg',
      name: 'Rye Bread',
      price: 1.80,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Bread',
      image: 'images/ciabatta.jpg',
      name: 'Ciabatta',
      price: 2.20,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Bread',
      image: 'images/multigrain_bread.jpg',
      name: 'Multigrain Bread',
      price: 1.60,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Bread',
      image: 'images/flatbread.jpg',
      name: 'Flatbread',
      price: 1.10,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Bread',
      image: 'images/bread_rolls.jpg',
      name: 'Bread Rolls',
      price: 0.90,
      color: 'Brown'),
];

List<Product> sampleTeas = [
  Product(
      id: Uuid().v4(),
      category: 'Tea',
      image: 'images/green_tea.jpg',
      name: 'Green Tea',
      price: 2.00,
      color: 'Green'),
  Product(
      id: Uuid().v4(),
      category: 'Tea',
      image: 'images/black_tea.jpg',
      name: 'Black Tea',
      price: 1.50,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Tea',
      image: 'images/herbal_tea.jpg',
      name: 'Herbal Tea',
      price: 2.50,
      color: 'Various'),
  Product(
      id: Uuid().v4(),
      category: 'Tea',
      image: 'images/chai_tea.jpg',
      name: 'Chai Tea',
      price: 2.20,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Tea',
      image: 'images/oolong_tea.jpg',
      name: 'Oolong Tea',
      price: 2.70,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Tea',
      image: 'images/white_tea.jpg',
      name: 'White Tea',
      price: 3.00,
      color: 'Light'),
  Product(
      id: Uuid().v4(),
      category: 'Tea',
      image: 'images/rooibos_tea.jpg',
      name: 'Rooibos Tea',
      price: 1.80,
      color: 'Red'),
  Product(
      id: Uuid().v4(),
      category: 'Tea',
      image: 'images/matcha_tea.jpg',
      name: 'Matcha Tea',
      price: 2.50,
      color: 'Green'),
  Product(
      id: Uuid().v4(),
      category: 'Tea',
      image: 'images/earl_grey_tea.jpg',
      name: 'Earl Grey Tea',
      price: 2.20,
      color: 'Brown'),
  Product(
      id: Uuid().v4(),
      category: 'Tea',
      image: 'images/peppermint_tea.jpg',
      name: 'Peppermint Tea',
      price: 1.90,
      color: 'Green'),
];
