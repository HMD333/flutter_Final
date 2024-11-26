import 'dart:convert';

import 'package:flutter_final_project/Theme/theme_manager.dart';
import 'package:flutter_final_project/Data/data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';

class UpdateUser extends StatefulWidget {
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  late final TextEditingController _usernameController =
      TextEditingController();
  late final TextEditingController _useremailController =
      TextEditingController();
  late final TextEditingController _userpasswordController =
      TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    _fetchAppointment();
    themeManager.addListener(themeListener);
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _useremailController.dispose();
    _userpasswordController.dispose();
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  void themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  void _fetchAppointment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList('users') ?? [];
    for (var userString in users) {
      Map<String, dynamic> user = jsonDecode(userString);
      if (user['userId'] == userId) {
        setState(() {
          _usernameController.text = user['userName'] ?? "";
          _useremailController.text = user['userEmail'] ?? "";
          _userpasswordController.text = user['userPassword'] ?? "";
        });
      }
    }
  }

  void _handleUpdate() async {
    String newname = _usernameController.text.trim();
    String newemail = _useremailController.text.trim();
    String newpassword = _userpasswordController.text.trim();

    if (newname.isNotEmpty || newemail.isNotEmpty || newpassword.isNotEmpty) {
      // Get SharedPreferences instance
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retrieve the existing users list from SharedPreferences
      List<String> users = prefs.getStringList('users') ?? [];

      // List to hold updated user strings
      List<String> updatedUsers = [];

      // Loop through existing users
      for (var userString in users) {
        // Decode the JSON string to a Map
        Map<String, dynamic> user = jsonDecode(userString);

        // Check if the current user ID matches the one we are updating
        if (user['userId'] == userId) {
          // Update user details
          user['userImage'] =
              _image?.path ?? user['userImage']; // Save image path if available
          user['userName'] = newname; // Update name
          user['userEmail'] = newemail; // Update email
          user['userPassword'] = newpassword; // Update password
        }

        // Add the updated user back to the updatedUsers list as a JSON string
        updatedUsers.add(jsonEncode(user));
      }

      // Save the updated users list back to SharedPreferences
      await prefs.setStringList('users', updatedUsers);

      // Navigate to home after updating
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show a message if no fields are filled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out at least one field'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Appointment'),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image == null ? null : FileImage(_image!),
                child:
                    _image == null ? Icon(Icons.add_a_photo, size: 50) : null,
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                label: Text('User name'),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _useremailController,
              decoration: InputDecoration(
                label: Text('Email'),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _userpasswordController,
              decoration: InputDecoration(
                label: Text('Password'),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _handleUpdate,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
