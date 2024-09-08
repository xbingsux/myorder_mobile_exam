import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myorder_mobile_exam/components/custom_card.dart';
import 'package:myorder_mobile_exam/profile/profile_detail.dart';
import 'controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.updateData,
          ),
        ],
      ),
      body: Obx(() {
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
                  final result = await Get.to(ProfileScreen(),
                      arguments: card['id'].toString());
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
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
