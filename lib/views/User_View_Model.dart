import 'package:api_project/model/Store_Model.dart';
import 'package:api_project/model/Token.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User_view_Model extends ChangeNotifier {
  static const String tokenKey = 'token';
  static const String emailKey = 'email';
  static const String storeLogoKey = 'storeLogo';
  static const String storetitleKey = 'storetitle';

  Future<bool> saveUser(UserToken user) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString(storeLogoKey, user.storeLogo.toString());
      notifyListeners();
      return true;
    } catch (e) {
      print('Error saving user: $e');
      return false;
    }
  }

  Future<UserToken?> getUser() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      final String? storeLogo = sp.getString(storeLogoKey);
      final String? storetitle = sp.getString(storetitleKey);
      return UserToken(storeLogo: storeLogo.toString(), storetitle: storetitle);
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  Future<bool> remove() async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.remove(storeLogoKey);
      return true;
    } catch (e) {
      print('Error removing user: $e');
      return false;
    }
  }

  // New method to save store logo from Stores object
  Future<bool> saveStoreLogo(Stores store) async {
    try {
      // Assuming that drWeblogo is the property containing the logo path
      String? storetitlepath = store.s30;
      String? storeLogoPath =
          store.drWeblogo; // Replace with the correct property name

      // Check if the storeLogoPath is null or empty
      if (storeLogoPath == null || storeLogoPath.isEmpty) {
        // Handle the case where the logo path is null or empty
        print('Error: Store logo path is null or empty');
        return false;
      }

      final SharedPreferences sp = await SharedPreferences.getInstance();
      // Append the base URL to the image path
      await sp.setString(storetitleKey, "$storetitlepath");
      await sp.setString(
          storeLogoKey, 'https://wakafridi.com/photos/$storeLogoPath');
      notifyListeners();
      return true;
    } catch (e) {
      print('Error saving store logo: $e');
      return false;
    }
  }
}
