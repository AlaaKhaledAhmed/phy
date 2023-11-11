import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Database/Database.dart';
import '../../Widget/AppBar.dart';
import '../../Widget/AppButtons.dart';
import '../../Widget/AppColor.dart';
import '../../Widget/AppLoading.dart';
import '../../Widget/AppMessage.dart';
import '../../Widget/AppTextFields.dart';
import '../../Widget/AppValidator.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(
          text: 'Change Password',
        ),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
//continent tittle-------------------------------------------------------------------
                    AppTextFields(
                      controller: oldPasswordController,
                      labelText: 'Old Password',
                      validator: (v) => AppValidator.validatorPassword(v),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextFields(
                      controller: newPasswordController,
                      labelText: 'New Password',
                      validator: (v) => AppValidator.validatorPassword(v),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppButtons(
                        onPressed: () async {
                          AppLoading.show(context, '', 'lode');
                          await Database.changPassword(
                                  currentUser: currentUser,
                                  email: currentUser!.email!,
                                  oldPass: oldPasswordController.text,
                                  newPassword: newPasswordController.text)
                              .then((v) {
                            if (v == "done") {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              AppLoading.show(
                                  context, 'Change Password', AppMessage.done);
                            } else {
                              Navigator.pop(context);
                              AppLoading.show(context, 'Change Password',
                                  'INVALID LOGIN CREDENTIALS');
                            }
                          });
                        },
                        text: 'Save'),
                  ]),
            ),
          ),
        ));
  }
}
