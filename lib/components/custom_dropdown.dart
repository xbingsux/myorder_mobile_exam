import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String labelText;
  final String? value;
  final List<Map<String, String>> items;
  final void Function(String?)? onChanged;

  CustomDropdown({
    required this.labelText,
    required this.value,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    String? dropdownValue =
        items.any((item) => item['key'] == value) ? value : null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            // color: Colors.amber,
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
            height: 48,
            child: DropdownButtonFormField<String>(
              value: dropdownValue,
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item['key'],
                        child: Text(item['value']!),
                      ))
                  .toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
