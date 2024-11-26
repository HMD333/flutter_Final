import 'package:flutter/material.dart';
import 'package:flutter_final_project/Pages/CreditCard.dart';
import 'package:flutter_final_project/Pages/Products/Bread.dart';
import 'package:flutter_final_project/Pages/Products/Fruits.dart';
import 'package:flutter_final_project/Pages/Products/Tea.dart';
import 'package:flutter_final_project/Pages/Products/Vegetables.dart';
import 'package:flutter_final_project/Pages/Index.dart';
import 'package:flutter_final_project/Pages/checkout_page.dart';
import 'package:flutter_final_project/Pages/registration/Login.dart';
import 'package:flutter_final_project/Pages/registration/Registrations.dart';
import 'package:flutter_final_project/Pages/Home.dart';
import 'package:flutter_final_project/Theme/theme_constants.dart';
import 'package:flutter_final_project/Theme/theme_manager.dart';
import 'package:flutter_final_project/Data/data.dart';
import 'package:flutter_final_project/Pages/Addresspage.dart';
import 'package:flutter_final_project/Pages/UpdateUser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: DarkTheme,
      themeMode: themeManager.themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => IndexPage(),
        '/login': (context) => LoginPage(),
        '/registration': (context) => RegistrationPage(),
        '/home': (context) => HomePage(productManager: ProductManager()),
        '/Vegetables': (context) => VegetablesScreen(),
        '/Fruits': (context) => FruitsScreen(),
        '/Bread': (context) => BreadScreen(),
        '/Tea': (context) => TeaScreen(),
        '/Checkout': (context) => CheckoutPage(),
        '/CreditCard': (context) => CreditCardPage(),
        '/address': (context) => AddressFormPage(),
        '/profile': (context) => UpdateUser()
      },
    );
  }
}
