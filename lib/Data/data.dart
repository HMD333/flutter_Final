import 'package:shared_preferences/shared_preferences.dart';

/// Class representing a Product
class Product {
  final int id;
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

/// Function to get the next unique ID for a product
Future<int> getNextId() async {
  final prefs = await SharedPreferences.getInstance();
  int currentId =
      prefs.getInt('current_product_id') ?? 0; // Get or default to 0
  currentId++; // Increment the ID
  await prefs.setInt('current_product_id', currentId); // Save the new ID
  return currentId; // Return the new ID
}

/// Function to save a product to SharedPreferences
Future<void> saveProduct(Product product) async {
  final prefs = await SharedPreferences.getInstance();

  // Get a unique ID for the new product
  int uniqueId = await getNextId();

  // Save each property using the unique ID
  await prefs.setInt('product_id_$uniqueId', uniqueId);
  await prefs.setString('product_category_$uniqueId', product.category);
  await prefs.setString('product_image_$uniqueId', product.image);
  await prefs.setString('product_name_$uniqueId', product.name);
  await prefs.setDouble('product_price_$uniqueId', product.price);
  await prefs.setString('product_color_$uniqueId', product.color);
}

/// Sample data initialization
List<Product> sampleProducts = [
  Product(
      id: 1,
      category: 'Vegetable',
      image: 'images/purple_cauliflower.jpg',
      name: 'Purple Cauliflower',
      price: 1.85,
      color: 'Purple'),
  Product(
      id: 2,
      category: 'Vegetable',
      image: 'images/savoy_cabbage.jpg',
      name: 'Savoy Cabbage',
      price: 1.45,
      color: 'Green'),
  Product(
      id: 3,
      category: 'Vegetable',
      image: 'images/carrot.jpg',
      name: 'Carrot',
      price: 0.80,
      color: 'Orange'),
  Product(
      id: 4,
      category: 'Vegetable',
      image: 'images/red_pepper.jpg',
      name: 'Red Pepper',
      price: 2.00,
      color: 'Red'),
  Product(
      id: 5,
      category: 'Vegetable',
      image: 'images/lettuce.jpg',
      name: 'Lettuce',
      price: 1.20,
      color: 'Green'),
  Product(
      id: 6,
      category: 'Vegetable',
      image: 'images/tomato.jpg',
      name: 'Tomato',
      price: 1.50,
      color: 'Red'),
  Product(
      id: 7,
      category: 'Vegetable',
      image: 'images/cucumber.jpg',
      name: 'Cucumber',
      price: 0.70,
      color: 'Green'),
  Product(
      id: 8,
      category: 'Vegetable',
      image: 'images/zucchini.jpg',
      name: 'Zucchini',
      price: 1.30,
      color: 'Green'),
  Product(
      id: 9,
      category: 'Vegetable',
      image: 'images/broccoli.jpg',
      name: 'Broccoli',
      price: 2.20,
      color: 'Green'),
  Product(
      id: 10,
      category: 'Vegetable',
      image: 'images/eggplant.jpg',
      name: 'Eggplant',
      price: 1.75,
      color: 'Purple'),
];

// Sample data for fruits, breads, and teas
List<Product> sampleFruits = [
  Product(
      id: 11,
      category: 'Fruit',
      image: 'images/apple.jpg',
      name: 'Apple',
      price: 1.00,
      color: 'Red'),
  Product(
      id: 12,
      category: 'Fruit',
      image: 'images/banana.jpg',
      name: 'Banana',
      price: 0.50,
      color: 'Yellow'),
  Product(
      id: 13,
      category: 'Fruit',
      image: 'images/orange.jpg',
      name: 'Orange',
      price: 0.75,
      color: 'Orange'),
  Product(
      id: 14,
      category: 'Fruit',
      image: 'images/grape.jpg',
      name: 'Grape',
      price: 2.00,
      color: 'Purple'),
  Product(
      id: 15,
      category: 'Fruit',
      image: 'images/strawberry.jpg',
      name: 'Strawberry',
      price: 1.50,
      color: 'Red'),
  Product(
      id: 16,
      category: 'Fruit',
      image: 'images/watermelon.jpg',
      name: 'Watermelon',
      price: 3.00,
      color: 'Green'),
  Product(
      id: 17,
      category: 'Fruit',
      image: 'images/kiwi.jpg',
      name: 'Kiwi',
      price: 1.20,
      color: 'Brown'),
  Product(
      id: 18,
      category: 'Fruit',
      image: 'images/pineapple.jpg',
      name: 'Pineapple',
      price: 2.50,
      color: 'Yellow'),
  Product(
      id: 19,
      category: 'Fruit',
      image: 'images/peach.jpg',
      name: 'Peach',
      price: 1.80,
      color: 'Yellow'),
  Product(
      id: 20,
      category: 'Fruit',
      image: 'images/blueberry.jpg',
      name: 'Blueberry',
      price: 2.20,
      color: 'Blue'),
];

List<Product> sampleBreads = [
  Product(
      id: 21,
      category: 'Bread',
      image: 'images/white_bread.jpg',
      name: 'White Bread',
      price: 1.00,
      color: 'Brown'),
  Product(
      id: 22,
      category: 'Bread',
      image: 'images/whole_wheat_bread.jpg',
      name: 'Whole Wheat Bread',
      price: 1.50,
      color: 'Brown'),
  Product(
      id: 23,
      category: 'Bread',
      image: 'images/sourdough_bread.jpg',
      name: 'Sourdough Bread',
      price: 2.00,
      color: 'Brown'),
  Product(
      id: 24,
      category: 'Bread',
      image: 'images/french_bread.jpg',
      name: 'French Bread',
      price: 1.75,
      color: 'Brown'),
  Product(
      id: 25,
      category: 'Bread',
      image: 'images/baguette.jpg',
      name: 'Baguette',
      price: 1.25,
      color: 'Brown'),
  Product(
      id: 26,
      category: 'Bread',
      image: 'images/rye_bread.jpg',
      name: 'Rye Bread',
      price: 1.80,
      color: 'Brown'),
  Product(
      id: 27,
      category: 'Bread',
      image: 'images/ciabatta.jpg',
      name: 'Ciabatta',
      price: 2.20,
      color: 'Brown'),
  Product(
      id: 28,
      category: 'Bread',
      image: 'images/multigrain_bread.jpg',
      name: 'Multigrain Bread',
      price: 1.60,
      color: 'Brown'),
  Product(
      id: 29,
      category: 'Bread',
      image: 'images/flatbread.jpg',
      name: 'Flatbread',
      price: 1.10,
      color: 'Brown'),
  Product(
      id: 30,
      category: 'Bread',
      image: 'images/bread_rolls.jpg',
      name: 'Bread Rolls',
      price: 0.90,
      color: 'Brown'),
];

List<Product> sampleTeas = [
  Product(
      id: 31,
      category: 'Tea',
      image: 'images/green_tea.jpg',
      name: 'Green Tea',
      price: 2.00,
      color: 'Green'),
  Product(
      id: 32,
      category: 'Tea',
      image: 'images/black_tea.jpg',
      name: 'Black Tea',
      price: 1.50,
      color: 'Brown'),
  Product(
      id: 33,
      category: 'Tea',
      image: 'images/herbal_tea.jpg',
      name: 'Herbal Tea',
      price: 2.50,
      color: 'Various'),
  Product(
      id: 34,
      category: 'Tea',
      image: 'images/chai_tea.jpg',
      name: 'Chai Tea',
      price: 2.20,
      color: 'Brown'),
  Product(
      id: 35,
      category: 'Tea',
      image: 'images/oolong_tea.jpg',
      name: 'Oolong Tea',
      price: 2.70,
      color: 'Brown'),
  Product(
      id: 36,
      category: 'Tea',
      image: 'images/white_tea.jpg',
      name: 'White Tea',
      price: 3.00,
      color: 'Light'),
  Product(
      id: 37,
      category: 'Tea',
      image: 'images/rooibos_tea.jpg',
      name: 'Rooibos Tea',
      price: 1.80,
      color: 'Red'),
  Product(
      id: 38,
      category: 'Tea',
      image: 'images/matcha_tea.jpg',
      name: 'Matcha Tea',
      price: 2.50,
      color: 'Green'),
  Product(
      id: 39,
      category: 'Tea',
      image: 'images/earl_grey_tea.jpg',
      name: 'Earl Grey Tea',
      price: 2.20,
      color: 'Brown'),
  Product(
      id: 40,
      category: 'Tea',
      image: 'images/peppermint_tea.jpg',
      name: 'Peppermint Tea',
      price: 1.90,
      color: 'Green'),
];

/// Example usage of ProductManager
void main() async {
  ProductManager productManager = ProductManager();

  // Initialize with sample products
  for (var product in sampleProducts) {
    productManager.addProduct(product);
  }
  for (var product in sampleFruits) {
    productManager.addProduct(product);
  }
  for (var product in sampleBreads) {
    productManager.addProduct(product);
  }
  for (var product in sampleTeas) {
    productManager.addProduct(product);
  }

  // Example: Count products in the 'Vegetable' category
  int vegetableCount = productManager.getCountByCategory('Vegetable');
  print('Total Vegetables: $vegetableCount');

  // // Save a new product
  // Product newProduct = Product(
  //   id: 0, // ID will be assigned automatically
  //   category: 'Vegetable',
  //   image: 'images/green_pepper.jpg',
  //   name: 'Green Pepper',
  //   price: 1.60,
  //   color: 'Green',
  // );

  // await saveProduct(newProduct);
}
