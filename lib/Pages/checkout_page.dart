import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/Data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _nonContactDelivery = true;
  bool _pickItUpMyself = false;
  bool _byCourier = false;
  bool _byDrone = false;
  int _selectedIndex = 0;

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
        // Ensure userId is defined
        setState(() {
          _cardNumber = user['cardNumber'] ?? '';
          _address = user['useraddres'] ?? '';
        });
      }
    }
  }

  void _onCheckout() {
    // Handle the checkout process, e.g., navigate to a confirmation page
    Navigator.pushReplacementNamed(
        context, '/home'); // Ensure this route is defined
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadUserInfo();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(color: Color(0xFF6A1B9A), fontSize: 25),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 17.0,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF6A1B9A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Method
            _buildSectionTitle('Payment method'),
            _buildPaymentMethod(),
            Divider(color: Colors.white),

            // Delivery Address
            _buildSectionTitle('Delivery address'),
            _buildDeliveryAddress(),
            Divider(color: Colors.white),

            // Delivery Options
            _buildSectionTitle('Delivery options'),
            _buildDeliveryOptions(),
            Divider(color: Colors.white),

            // Non-contact Delivery Toggle
            // _buildNonContactDeliveryToggle(),
            SizedBox(height: 20),

            // Checkout Button
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
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Color(0xFF6A1B9A),
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return ListTile(
      leading: Transform.translate(
        offset: Offset(-15, 0),
        child: Icon(Icons.credit_card, color: Color(0xFF6A1B9A)),
      ),
      title: Text(
        _cardNumber.isNotEmpty ? _cardNumber : 'No card selected',
        style: TextStyle(color: Colors.grey),
      ),
      trailing: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/CreditCard');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFAB47EC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text('Change', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Column(
      children: [
        _buildDeliveryOption('I\'ll pick it up myself', _pickItUpMyself,
            (value) {
          setState(() {
            _pickItUpMyself = value!;
          });
        }),
        _buildDeliveryOption('By courier', _byCourier, (value) {
          setState(() {
            _byCourier = value!;
          });
        }),
        _buildDeliveryOption('By Drone', _byDrone, (value) {
          setState(() {
            _byDrone = value!;
          });
        }),
      ],
    );
  }

  Widget _buildDeliveryOption(
      String title, bool value, ValueChanged<bool?> onChanged) {
    return CheckboxListTile(
      title: Row(
        children: [
          Icon(
            Icons.local_shipping,
            color: value ? Color(0xFF6A1B9A) : Colors.grey,
          ),
          SizedBox(width: 8.0),
          Text(
            title,
            style: TextStyle(color: value ? Color(0xFF6A1B9A) : Colors.grey),
          ),
        ],
      ),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.trailing,
      checkColor: Color(0xFF6A1B9A),
      activeColor: Colors.transparent,
      side: BorderSide.none,
    );
  }

  // Widget _buildNonContactDeliveryToggle() {
  //   return ListTile(
  //     title: Text('Non-contact delivery'),
  //     trailing: GestureDetector(
  //       onTap: () {
  //         setState(() {
  //           _nonContactDelivery = !_nonContactDelivery;
  //         });
  //       },
  //       child: AnimatedContainer(
  //         duration: Duration(milliseconds: 300),
  //         width: 70,
  //         height: 35,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20.0),
  //           color: _nonContactDelivery ? Color(0xFFAB47EC) : Colors.grey,
  //         ),
  //         child: Stack(
  //           children: [
  //             Align(
  //               alignment: _nonContactDelivery
  //                   ? Alignment.centerRight
  //                   : Alignment.centerLeft,
  //               child: Container(
  //                 width: 30,
  //                 height: 30,
  //                 margin: EdgeInsets.symmetric(horizontal: 3.0),
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(15.0),
  //                 ),
  //               ),
  //             ),
  //             Align(
  //               alignment: _nonContactDelivery
  //                   ? Alignment.centerLeft
  //                   : Alignment.centerRight,
  //               child: Padding(
  //                 padding: EdgeInsets.symmetric(horizontal: 8.0),
  //                 child: Text(
  //                   _nonContactDelivery ? 'Yes' : 'No',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
