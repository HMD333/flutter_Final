import 'package:flutter/material.dart';
import 'package:flutter_final_project/CreditCard.dart';
import 'package:flutter_final_project/Pages/Products/Bread.dart';
import 'package:flutter_final_project/Pages/Products/Fruits.dart';
import 'package:flutter_final_project/Pages/Products/Tea.dart';
import 'package:flutter_final_project/Pages/Products/Vegetables.dart';

import 'package:flutter_final_project/Pages/Index.dart';
import 'package:flutter_final_project/Pages/registration/Login.dart';
import 'package:flutter_final_project/Pages/registration/Registrations.dart';
import 'package:flutter_final_project/Pages/Home.dart';
import 'package:flutter_final_project/Theme/theme_constants.dart';
import 'package:flutter_final_project/Theme/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: DarkTheme,
      themeMode: themeManager.themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => CreditCardPage(),
        '/login': (context) => LoginPage(),
        '/registration': (context) => RegistrationPage(),
        '/home': (context) => HomePage(),
        '/Vegetables': (context) => VegetablesScreen(),
        '/Fruits': (context) => FruitsScreen(),
        '/Bread': (context) => BreadScreen(),
        '/Tea': (context) => TeaScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
