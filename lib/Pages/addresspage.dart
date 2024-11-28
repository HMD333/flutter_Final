import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_final_project/Data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressFormPage extends StatefulWidget {
  @override
  _AddressFormPageState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _streetAddress = '';
  String _city = '';
  String _postalCode = '';
  String _country = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _loadUserInfo();
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
          _name = oldaddress[0];
          _streetAddress = oldaddress[1];
          _city = oldaddress[2];
          _postalCode = oldaddress[3];
          _country = oldaddress[4];
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
            '$_name\n$_streetAddress\n$_postalCode\n$_country';

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
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _streetAddress,
                decoration: InputDecoration(labelText: 'Street Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your street address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _streetAddress = value!;
                },
              ),
              TextFormField(
                initialValue: _city,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
                onSaved: (value) {
                  _city = value!;
                },
              ),
              TextFormField(
                initialValue: _postalCode,
                decoration: InputDecoration(labelText: 'Postal Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your postal code';
                  }
                  return null;
                },
                onSaved: (value) {
                  _postalCode = value!;
                },
              ),
              TextFormField(
                initialValue: _country,
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your country';
                  }
                  return null;
                },
                onSaved: (value) {
                  _country = value!;
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
