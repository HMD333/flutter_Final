import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _nonContactDelivery = true;
  // String _selectedDeliveryOption = 'By Drone';

  // إضافة متغيرات حالة للتحقق من حالة CheckBox
  bool _pickItUpMyself = false;
  bool _byCourier = false;
  bool _byDrone = false;

  // متغير لتخزين الفهرس النشط في BottomNavigationBar
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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

            //**********************************************   Payment method   ****************************************************************

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Payment method',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A1B9A),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Payment method button pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFAB47EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Change', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            ListTile(
              leading: Transform.translate(
                offset: Offset(-15, 0),
                child: Icon(Icons.credit_card, color: Color(0xFF6A1B9A)),
              ),
              title: const Text(
                '**** **** **** 4747',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Divider(color: Colors.white),

            //*************************************************   Delivery address   ***********************************************************

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delivery address',
                  style: TextStyle(
                    color: Color(0xFF6A1B9A),
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Delivery address button pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFAB47EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Change', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            ListTile(
              leading: Transform.translate(
                offset: Offset(-15, 0),
                child: Icon(Icons.home_outlined, color: Color(0xFF6A1B9A)),
              ),
              title: const Text(
                'Alexandra Smith\nCesu 31 k-2 5.st, SIA Chili\nRiga\nLV-1012\nLatvia',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Divider(color: Colors.white),

            //******************************************************   Delivery options   **********************************************************

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delivery options',
                  style: TextStyle(
                    color: Color(0xFF6A1B9A),
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Delivery options button pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFAB47EC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Change', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            CheckboxListTile(
              title: Row(
                children: [
                  Icon(Icons.directions_walk, color: _pickItUpMyself ? Color(0xFF6A1B9A) : Colors.grey),
                  SizedBox(width: 8.0),
                  Text(
                    'I\'ll pick it up myself',
                    style: TextStyle(color: _pickItUpMyself ? Color(0xFF6A1B9A) : Colors.grey),
                  ),
                ],
              ),
              value: _pickItUpMyself,
              onChanged: (bool? value) {
                setState(() {
                  _pickItUpMyself = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.trailing,
              checkColor: Color(0xFF6A1B9A), // لون علامة الصح
              activeColor: Colors.transparent, // جعل الخلفية شفافة
              side: BorderSide.none, // إخفاء مربع التحقق
            ),
            CheckboxListTile(
              title: Row(
                children: [
                  Icon(Icons.local_shipping, color: _byCourier ? Color(0xFF6A1B9A) : Colors.grey),
                  SizedBox(width: 8.0),
                  Text(
                    'By courier',
                    style: TextStyle(color: _byCourier ? Color(0xFF6A1B9A) : Colors.grey),
                  ),
                ],
              ),
              value: _byCourier,
              onChanged: (bool? value) {
                setState(() {
                  _byCourier = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.trailing,
              checkColor: Color(0xFF6A1B9A), // لون علامة الصح
              activeColor: Colors.transparent, // جعل الخلفية شفافة
              side: BorderSide.none, // إخفاء مربع التحقق
            ),
            CheckboxListTile(
              title: Row(
                children: [
                  Icon(Icons.airplanemode_active, color: _byDrone ? Color(0xFF6A1B9A) : Colors.grey),
                  SizedBox(width: 8.0),
                  Text(
                    'By Drone',
                    style: TextStyle(color: _byDrone ? Color(0xFF6A1B9A) : Colors.grey),
                  ),
                ],
              ),
              value: _byDrone,
              onChanged: (bool? value) {
                setState(() {
                  _byDrone = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.trailing,
              checkColor: Color(0xFF6A1B9A), // لون علامة الصح
              activeColor: Colors.transparent, // جعل الخلفية شفافة
              side: BorderSide.none, // إخفاء مربع التحقق
            ),
            Divider(color: Colors.white),
            ListTile(
              title: Text('Non-contact delivery'),
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    _nonContactDelivery = !_nonContactDelivery;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 70,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: _nonContactDelivery ? Color(0xFFAB47EC) : Colors.grey,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: _nonContactDelivery ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: _nonContactDelivery ? Alignment.centerLeft : Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            _nonContactDelivery ? 'Yes' : 'No',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF6A1B9A), // لون العنصر المحدد
        onTap: _onItemTapped,
      ),
    );
  }
}

