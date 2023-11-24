import 'package:flutter/material.dart';

class Subtotal extends StatefulWidget {
  const Subtotal({super.key});

  @override
  State<Subtotal> createState() => _SubtotalState();
}

class _SubtotalState extends State<Subtotal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 50,
        child: Row(
          children: [
            Text("Subtotal",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(width: 10,),
            RichText(
  text: TextSpan(
    style: DefaultTextStyle.of(context).style,
    children: [
      TextSpan(
            text: '0.00',
            style: TextStyle(
              fontSize: 18, // You can adjust the size to fit your design
              color: Colors.black, // You can set the color you prefer
            ),
      ),
      TextSpan(
            text: 'EGP',
            style: TextStyle(
              fontSize: 13, // You can adjust the size to fit your design
              fontWeight: FontWeight.bold,
              color: Colors.black, // You can set the color you prefer
            ),
      ),
    ],
  ),
),
          ],
        )
),
      
    );
  }
}