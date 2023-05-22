import 'package:customers/screen/customer_list.dart';
import 'package:flutter/material.dart';

import 'package:customers/screen/signin_screen.dart';
import 'package:customers/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:customers/screen/discount_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4"),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                210, MediaQuery.of(context).size.height * 0.2, 80, 490),
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      print("Signed Out");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ));
                    });
                  },
                  child: const Text("Logoutt"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerList(),
                        ));
                  },
                  child: const Text("Customers"),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => discountList(),
                        ));
                  },
                  child: const Text("Discount"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
