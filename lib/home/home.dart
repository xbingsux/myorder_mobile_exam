import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myorder_mobile_exam/components/custom_card.dart';
import 'package:myorder_mobile_exam/profile/profile_detail.dart';
import 'controller.dart'; // Import HomeController

class HomePage extends StatelessWidget {
  final HomeController controller =
      Get.put(HomeController()); // สร้าง instance ของ HomeController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh), // ใช้ไอคอนรีโหลด
            onPressed: controller.updateData, // เมื่อกดปุ่มจะอัปเดตข้อมูล
          ),
        ],
      ),
      body: Obx(() {
        // return CustomCard();
        // ใช้ Obx เพื่ออัปเดตหน้าจอเมื่อข้อมูลเปลี่ยนแปลง
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            itemCount: controller.cardList.length,
            itemBuilder: (context, index) {
              final card = controller.cardList[index];
              return CustomCard(
                data: card,
                onDelete: () => controller.deleteItem(card['id'].toString()),
                onUpdate: () async {
                  // รอผลลัพธ์จากการอัปเดตข้อมูลในหน้า ProfileScreen
                  final result = await Get.to(ProfileScreen(),
                      arguments: card['id'].toString());

                  // ถ้าผลลัพธ์เป็น true ให้รีเฟรชข้อมูลใน HomePage
                  if (result == true) {
                    controller.updateData();
                  }
                },
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.to(ProfileScreen());
          if (result == true) {
            controller.updateData();
          }
        }, // กดปุ่มเพื่ออัปเดตข้อมูล
        child: Icon(Icons.add),
      ),
    );
  }
}
