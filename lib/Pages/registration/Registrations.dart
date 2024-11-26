import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  File? _image;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      var uuid = Uuid();
      String userId = uuid.v4();

      Map<String, dynamic> newUser = {
        'userId': userId,
        'userName': nameController.text,
        'userEmail': emailController.text,
        'userPassword': passwordController.text,
        'userImage': _image?.path,
        'cardNumber': '4747 4747 4747 4747',
        'useraddres':
            'Alexandra Smith\nCesu 31 k-2 5.st, SIA Chili\nRiga\nLV-1012\nLatvia'
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> users = prefs.getStringList('users') ?? [];
      users.add(jsonEncode(newUser));
      await prefs.setStringList('users', users);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );

      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<List<Map<String, dynamic>>> _getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> users = prefs.getStringList('users') ?? [];
    return users
        .map((user) => jsonDecode(user))
        .toList()
        .cast<Map<String, dynamic>>();
  }

  @override
  void initState() {
    super.initState();
    // Load users if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.endsWith('@gmail.com')) {
                    return 'Your email must end with @gmail.com';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => _isObscure = !_isObscure),
                  ),
                ),
                obscureText: _isObscure,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 3) {
                    return 'Your password must be more than 3 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image == null ? null : FileImage(_image!),
                  child:
                      _image == null ? Icon(Icons.add_a_photo, size: 50) : null,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
