import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var cardList = <Map<String, dynamic>>[].obs;
  final String baseUrl = dotenv.env['BASE_URL']!; // Read from .env

  // ฟังก์ชันเพื่อดึงข้อมูลจาก API
  Future<void> updateData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/profiles'));
      print('$baseUrl/profiles');
      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body) as List;
        cardList.value =
            decodedData.map((data) => Map<String, dynamic>.from(data)).toList();
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteItem(String id) async {
    final url = Uri.parse('$baseUrl/profiles/$id');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        // cardList.removeAt(index);
        updateData();
      } else {
        print('Failed to delete item from API');
      }
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    updateData(); // เรียก updateData เมื่อ Controller ถูกสร้างขึ้น
  }
}
