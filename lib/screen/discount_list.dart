import 'package:flutter/material.dart';

class discountList extends StatefulWidget {
  const discountList({super.key});

  @override
  State<discountList> createState() => _discountListState();
}

class _discountListState extends State<discountList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.amber,
      ),
    );
  }
}
