import 'package:flutter/material.dart';

class CustomAvartar extends StatelessWidget {
  final String? imgLink;

  CustomAvartar({
    required this.imgLink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: CircleAvatar(
        radius: 50,
        child: Icon(Icons.person, size: 80),
      ),
    );
  }
}
