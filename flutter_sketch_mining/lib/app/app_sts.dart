
import 'package:flutter/material.dart';

class AppSts extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade800,
      child: const Center(
        child: Text(
          'Free sFuel PoC',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0
          ),
        ),
      ),
    );    
  }
}