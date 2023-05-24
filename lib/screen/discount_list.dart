import 'package:customers/screen/home_screen.dart';
import 'package:flutter/material.dart';

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
      home: DiscountList(),
    );
  }
}

class DiscountList extends StatefulWidget {
  const DiscountList({super.key});

  //final String title;

  @override
  State<DiscountList> createState() => _discountListState();
}

class _discountListState extends State<DiscountList> {
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
        title: Text('Customer Discounts'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            child: singleCard(59490, 'Clock'),
          ),
          singleCard(59200, 'clock'),
          singleCard(59340, 'clock'),
          singleCard(59440, 'clock'),
        ],
      ),
    );
  }
}
