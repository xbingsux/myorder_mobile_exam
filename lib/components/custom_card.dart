import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  CustomCard({
    required this.data,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // เพิ่มการทำให้มุมโค้งมน
      ),
      // margin: EdgeInsets.all(10),
      child: ExpansionTile(
        title: Text(
          data['email'],
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          data['gender'] != null ? data['gender'].toString() : "Not Specified",
        ),
        expandedAlignment: Alignment.topLeft,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myText("PINCODE", data['pincode']),
                myText("ADDRESS", data['addr']),
                myText("CITY", data['city']),
                myText("STATE", data['state']),
                myText("COUNTRY", data['country']),
                myText("BANK ACCOUNT", data['bank_account_number']),
                myText("HOLDER NAME", data['account_holder_name']),
                myText("IFSC", data['ifsc_code']),
                myDate("LAST UPDATE", data['updatedAt']),
                myDate("CREATE", data['createdAt']),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // สีพื้นหลังของปุ่ม
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // เพิ่มมุมโค้งมนให้กับปุ่ม
                          ),
                        ),
                        onPressed: () {
                          onUpdate(); // เมื่อกดปุ่มจะเรียกฟังก์ชันนี้
                        },
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min, // ขนาดของ Row ให้พอดีกับเนื้อหา
                          children: [
                            Icon(Icons.edit, color: Colors.white), // ไอคอนลบ
                            SizedBox(
                                width: 8), // ระยะห่างระหว่างไอคอนและข้อความ
                            Text('Edit'), // ข้อความ
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // เปิดไดอะล็อกเพื่อถามยืนยันก่อนลบ
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirm Delete'),
                                content: Text(
                                    'Are you sure you want to delete this item?'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // เพิ่มมุมโค้งมน
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // ปิดไดอะล็อก
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // ปิดไดอะล็อกก่อนลบ
                                      onDelete(); // เรียกฟังก์ชันลบ
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget myText(title, text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        title + " : " + (text != null ? text.toString() : "-"),
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }

  Widget myDate(title, text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        title + " : " + (text != null ? formatDate(text.toString()) : "-"),
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }

  String formatDate(String? dateString) {
    if (dateString == null) {
      return "-";
    }
    DateTime dateTime = DateTime.parse(dateString);

    // กำหนดชื่อเดือนในภาษาอังกฤษ
    List<String> engMonths = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${dateTime.day} ${engMonths[dateTime.month - 1]} ${dateTime.year}';
  }
}
