import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final String initialValue;

  CustomTextField(
      {required this.labelText,
      this.validator,
      this.onSaved,
      this.obscureText = false,
      this.initialValue = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              labelText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                // labelText: labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),

                filled: true,
                fillColor: Colors.white,
              ),
              initialValue: initialValue,
              obscureText: obscureText,
              validator: validator,
              onSaved: onSaved,
            ),
          ),
        ],
      ),
    );
  }
}
