import 'package:customers/screen/customer_list.dart';
import 'package:flutter/material.dart';

import 'package:customers/screen/signin_screen.dart';
import 'package:customers/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:customers/screen/setup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gridview',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  //final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    singleCard(iconcode, icontitle) {
      return Card(
        color: Colors.white,
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //icon
              Icon(
                IconData(iconcode, fontFamily: 'MaterialIcons'),
                color: Colors.black,
                size: 85.0,
              ),
              //titile
              Text(
                icontitle,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerList(),
                ),
              );
            },
            child: singleCard(0xeb7e, 'Customers'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SetUp(),
                ),
              );
            },
            child: singleCard(0xf67c, 'Cards'),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SetUp(),
                ),
              );
            },
            child: singleCard(0xe4b3, 'SetUp'),
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              });
            },
            child: singleCard(0xf02db, 'Logout'),
          ),
        ],
      ),
    );
  }
}
