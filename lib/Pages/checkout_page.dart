import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/Data/data.dart';
import 'package:flutter_final_project/Pages/ShoppingCart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int _selectedDeliveryOption = 0; // Track the selected delivery option
  String _cardNumber = '';
  String _address = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList('users') ?? [];
    for (var userString in users) {
      Map<String, dynamic> user = jsonDecode(userString);
      if (user['userId'] == userId) {
        setState(() {
          _cardNumber = user['cardNumber'] ?? '';
          _address = user['useraddres'] ?? '';
        });
      }
    }
  }

  void clearasket() {
    print(basketManager.baskets.length);
    setState(() {
      basketManager.baskets.clear();
    });
  }

  String _getLastFourCardNumber(String cardNumber) {
    return cardNumber.length >= 4
        ? cardNumber.substring(cardNumber.length - 4)
        : cardNumber;
  }

  void _onCheckout() {
    clearasket();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You have paid ${basketManager.Totel}')),
    );
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(fontSize: 25)),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
          iconSize: 17.0,
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Payment method'),
            _buildPaymentMethod(),
            Divider(color: Colors.white),
            _buildSectionTitle('Delivery address'),
            _buildDeliveryAddress(),
            Divider(color: Colors.white),
            _buildSectionTitle('Delivery options'),
            _buildDeliveryOptions(),
            Divider(color: Colors.white),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _onCheckout,
                child: const Text('Proceed to Checkout'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 23, fontWeight: FontWeight.bold, color: Color(0xFF6A1B9A)),
    );
  }

  Widget _buildPaymentMethod() {
    return ListTile(
      leading: Transform.translate(
        offset: Offset(-15, 0),
        child: Icon(Icons.credit_card, color: Color(0xFF6A1B9A)),
      ),
      title: Text(
        _cardNumber.isNotEmpty
            ? '**** **** **** ${_getLastFourCardNumber(_cardNumber)}'
            : 'No card selected',
        style: TextStyle(color: Colors.grey),
      ),
      trailing: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/CreditCard');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFAB47EC),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Text('Change', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return ListTile(
      leading: Transform.translate(
        offset: Offset(-15, 0),
        child: Icon(Icons.home_outlined, color: Color(0xFF6A1B9A)),
      ),
      title: Text(
        _address.isNotEmpty ? _address : 'No address selected',
        style: TextStyle(color: Colors.grey),
      ),
      trailing: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/address');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFAB47EC),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Text('Change', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Column(
      children: [
        _buildDeliveryOption(
            'I\'ll pick it up myself', 0, Icons.directions_run_outlined),
        _buildDeliveryOption('By courier', 1, Icons.local_shipping),
        _buildDeliveryOption('By Drone', 2, Icons.airplanemode_on_outlined),
      ],
    );
  }

  Widget _buildDeliveryOption(String title, int index, IconData icon) {
    return RadioListTile<int>(
      title: Row(
        children: [
          Icon(icon,
              color: _selectedDeliveryOption == index
                  ? Color(0xFF6A1B9A)
                  : Colors.grey),
          SizedBox(width: 8.0),
          Text(
            title,
            style: TextStyle(
                color: _selectedDeliveryOption == index
                    ? Color(0xFF6A1B9A)
                    : Colors.grey),
          ),
        ],
      ),
      value: index,
      groupValue: _selectedDeliveryOption,
      onChanged: (value) {
        setState(() {
          _selectedDeliveryOption = value!;
        });
      },
      activeColor: Color(0xFFAB47EC),
    );
  }
}
