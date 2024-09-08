import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final String baseUrl = dotenv.env['BASE_URL']!;
  var email = ''.obs;
  var password = ''.obs;
  var gender = 'N'.obs;

  var pincode = ''.obs;
  var addr = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var country = ''.obs;
  var bank_account_number = ''.obs;
  var account_holder_name = ''.obs;
  var ifsc_code = ''.obs;

  var formKey = GlobalKey<FormState>();
  String? profileId;

  var isLoading = false.obs;

  Future<void> getProfileData(String id) async {
    isLoading.value = true;
    final url = Uri.parse('$baseUrl/profiles/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        email.value = data['email'];
        password.value = data['password'];
        gender.value = data['gender'];
        pincode.value = data['pincode'];
        addr.value = data['addr'];
        city.value = data['city'];
        state.value = data['state'];
        country.value = data['country'];
        bank_account_number.value = data['bank_account_number'];
        account_holder_name.value = data['account_holder_name'];
        ifsc_code.value = data['ifsc_code'];
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error fetching profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void resetFields() {
    profileId = null;
    email.value = '';
    password.value = '';
    gender.value = 'N';
    pincode.value = '';
    addr.value = '';
    city.value = '';
    state.value = '';
    country.value = '';
    bank_account_number.value = '';
    account_holder_name.value = '';
    ifsc_code.value = '';
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == "" || value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> saveForm() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final url = Uri.parse('$baseUrl/profiles');
      final profileData = {
        'id': profileId,
        'email': email.value,
        'password': password.value,
        'gender': gender.value,
        'pincode': pincode.value,
        'address': addr.value,
        'city': city.value,
        'state': state.value,
        'country': country.value,
        'bank_account_number': bank_account_number.value,
        'account_holder_name': account_holder_name.value,
        'ifsc_code': ifsc_code.value,
      };

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(profileData),
        );
        if (response.statusCode == 201) {
          Get.back(result: true);
          Get.snackbar('Success', 'Profile saved successfully');
        } else {
          var errorMessage = 'Failed to save profile';
          try {
            final errorData = json.decode(response.body);
            errorMessage = errorData['message'] ?? errorMessage;
          } catch (e) {
            errorMessage = response.body.toString();
          }

          Get.snackbar('Failed', errorMessage);
        }
      } catch (e) {
        print('Error saving profile: $e');
        Get.snackbar('Error', 'Error saving profile: $e');
      }
    }
  }
}
