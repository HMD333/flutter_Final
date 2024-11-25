import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:flutter_final_project/Theme/theme_manager.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState(); // Corrected method name
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    double heigth_550px = MediaQuery.of(context).size.height - 550;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 12, 87),
      body: Stack(
        children: [
          Image.asset('images/BG.png'),
          Padding(
            padding: EdgeInsets.only(top: heigth_550px),
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(150, 0, 0, 0),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                  color: Color.fromARGB(200, 255, 255, 255),
                ),
                height: 550,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: const Alignment(0, -.5),
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      width: 100,
                      height: 100,
                      child: Image.asset('images/box.png'),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Text(
                        "Deliverie's Ontime",
                        style: TextStyle(
                            color: Color.fromARGB(255, 45, 12, 87),
                            fontWeight: FontWeight.w800,
                            fontSize: 40),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 350),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text(
                            "Try out",
                            style: TextStyle(
                              color: Color.fromARGB(255, 45, 12, 87),
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          )),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
