import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_final_project/Data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreditCardPage extends StatefulWidget {
  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  final _formKey = GlobalKey<FormState>(); // Key for the form

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();

  String nameController = 'ALEXANDRA SMITH';
  String cardNumberController = '4747 4747 4747 4747';
  String expiryDateController = '07/21';
  String cvcController = '';

  void _filterCategories() {
    setState(() {
      if (_nameController.text.isNotEmpty &&
          _cardNumberController.text.isNotEmpty &&
          _expiryDateController.text.isNotEmpty &&
          _cvcController.text.isNotEmpty) {
        _loadUserInfo();
        Navigator.pushReplacementNamed(context, '/Checkout');
      }
    });
  }

  void _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList('users') ?? [];
    List<String> updatedUsers = []; // List to hold updated user strings

    for (var userString in users) {
      Map<String, dynamic> user = jsonDecode(userString);
      if (user['userId'] == userId) {
        // Update the card number from the controller
        user['cardNumber'] = _cardNumberController.text;

        // Add the updated user back to the updatedUsers list
        updatedUsers.add(jsonEncode(user));
      } else {
        // If the user is not the one being updated, keep the original user string
        updatedUsers.add(userString);
      }
    }

    // Save the updated users list back to SharedPreferences
    await prefs.setStringList('users', updatedUsers);

    // Optionally, update the state to reflect the changes in the UI
    setState(() {
      // If necessary, you can also update other UI elements or state variables here
    });
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    _nameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Credit / Debit Card",
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // // Title
              // const Text(
              //   "Credit / Debit Card",
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //   ),
              // ),
              const SizedBox(height: 20),

              // Card display
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card number
                    Text(
                      cardNumberController,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          nameController.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          expiryDateController,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Name on card
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name on Card",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name on the card';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Card number
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: "Card Number",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.credit_card),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  if (value.length != 16) {
                    return 'Card number must be 16 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Expiry date and CVC
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _expiryDateController,
                      decoration: const InputDecoration(
                        labelText: "Expiry Date (MM/YY)",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter expiry date';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _cvcController,
                      decoration: const InputDecoration(
                        labelText: "CVC",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter CVC';
                        }
                        if (value.length != 3) {
                          return 'CVC must be 3 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, proceed with the action

                    _filterCategories();

                    // You can add your logic for using the card here
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "USE THIS CARD",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
