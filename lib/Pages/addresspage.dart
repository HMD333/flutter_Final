import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_final_project/Data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressFormPage extends StatefulWidget {
  @override
  _AddressFormPageState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _streetAddress = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  final TextEditingController _country = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String name = '';
  String streetAddress = '';
  String city = '';
  String postalCode = '';
  String country = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _UpdateUserInfo();
      Navigator.pushReplacementNamed(context, '/Checkout');
    }
  }

  void _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList('users') ?? [];
    for (var userString in users) {
      Map<String, dynamic> user = jsonDecode(userString);
      if (user['userId'] == userId) {
        List<String> oldaddress = user['useraddres'].toString().split('\n');
        setState(() {
          name = oldaddress[0];
          streetAddress = oldaddress[1];
          city = oldaddress[2];
          postalCode = oldaddress[3];
          country = oldaddress[4];
        });
      }
    }
  }

  void _UpdateUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList('users') ?? [];
    List<String> updatedUsers = []; // List to hold updated user strings

    for (var userString in users) {
      Map<String, dynamic> user = jsonDecode(userString);
      if (user['userId'] == userId) {
        // Update the user address
        user['userAddress'] =
            '${_name.text}\n${_streetAddress.text}\n${_city.text}\n${_postalCode.text}\n${_country.text}';

        // Add the updated user back to the updatedUsers list
        updatedUsers.add(jsonEncode(user));
      }
    }

    // Save the updated users list back to SharedPreferences
    await prefs.setStringList('users', updatedUsers);
  }

  @override
  Widget build(BuildContext context) {
    _loadUserInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text('Address Form'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: streetAddress,
                decoration: InputDecoration(labelText: 'Street Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your street address';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: city,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: postalCode,
                decoration: InputDecoration(labelText: 'Postal Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your postal code';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: country,
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your country';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
