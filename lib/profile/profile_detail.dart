import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myorder_mobile_exam/components/custom_avartar.dart';
import 'package:myorder_mobile_exam/components/custom_dropdown.dart';
import 'package:myorder_mobile_exam/profile/controller.dart';
import 'package:myorder_mobile_exam/components/custom_text_field.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final String? profileId = Get.arguments as String?;
    if (profileId != null) {
      controller.profileId = profileId;
      controller.getProfileData(profileId);
    } else {
      controller.resetFields();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFDFDFD),
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView(
            children: [
              Container(
                color: Color(0xFFFDFDFD),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAvartar(imgLink: null),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Personal Details',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        CustomTextField(
                          labelText: 'Email Address',
                          onSaved: (value) {
                            controller.email.value = value!;
                          },
                          validator: controller.validateEmail,
                          initialValue: controller.email.value,
                        ),
                        CustomTextField(
                          labelText: 'Password',
                          // obscureText: true,
                          onSaved: (value) {
                            controller.password.value = value!;
                          },
                          validator: controller.validatePassword,
                          initialValue: controller.password.value,
                        ),
                        CustomDropdown(
                          labelText: 'Gender',
                          value: controller.gender.value,
                          items: const [
                            {'key': 'M', 'value': 'Male'},
                            {'key': 'F', 'value': 'Female'},
                            {'key': 'N', 'value': 'Not Specified'},
                          ],
                          onChanged: (value) {
                            controller.gender.value = value!;
                          },
                        ),
                        myTitle('Address Details'),
                        CustomTextField(
                          labelText: 'Pincode',
                          onSaved: (value) {
                            controller.pincode.value = value!;
                          },
                          initialValue: controller.pincode.value,
                        ),
                        CustomTextField(
                          labelText: 'Address',
                          onSaved: (value) {
                            controller.addr.value = value!;
                          },
                          initialValue: controller.addr.value,
                        ),
                        CustomTextField(
                          labelText: 'City',
                          onSaved: (value) {
                            controller.city.value = value!;
                          },
                          initialValue: controller.city.value,
                        ),
                        CustomTextField(
                          labelText: 'State',
                          onSaved: (value) {
                            controller.state.value = value!;
                          },
                          initialValue: controller.state.value,
                        ),
                        CustomTextField(
                          labelText: 'Country',
                          onSaved: (value) {
                            controller.country.value = value!;
                          },
                          initialValue: controller.country.value,
                        ),
                        myTitle('Bank Account Details'),
                        CustomTextField(
                          labelText: 'Bank Account Number',
                          onSaved: (value) {
                            controller.bank_account_number.value = value!;
                          },
                          initialValue: controller.bank_account_number.value,
                        ),
                        CustomTextField(
                          labelText: 'Account Holder Name',
                          onSaved: (value) {
                            controller.account_holder_name.value = value!;
                          },
                          initialValue: controller.account_holder_name.value,
                        ),
                        CustomTextField(
                          labelText: 'IFSC Code',
                          onSaved: (value) {
                            controller.ifsc_code.value = value!;
                          },
                          initialValue: controller.ifsc_code.value,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Color(0xFF4392F9),
                              elevation: 0,
                              shadowColor: Colors.white,
                              minimumSize: Size(double.infinity, 50),
                            ),
                            onPressed: controller.saveForm,
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget myTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.50,
              color: Color(0xFFC4C4C4),
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
