import 'package:api_project/model/Token.dart';
import 'package:api_project/utils/RoutName.dart';
import 'package:api_project/views/User_View_Model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashServices {
  Future<UserToken?> getUserData() => User_view_Model().getUser();

  void Check_Authentication_User(BuildContext context) {
    // If a user is authenticated, retrieve user data and navigate to the appropriate page.
    getUserData().then((value) {
      if (value != null) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushNamed(context, Routesname.Resposive_layout);
        });  
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
