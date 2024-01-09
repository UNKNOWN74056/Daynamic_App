import 'package:api_project/provider/Validation_item.dart';
import 'package:flutter/material.dart';

class ValidationProvider extends ChangeNotifier {
  late validaitonitem _name = validaitonitem(null, null);
  late validaitonitem _address = validaitonitem(null, null);
  late validaitonitem _whatsapp = validaitonitem(null, null);
  late validaitonitem _email = validaitonitem(null, null);

  validaitonitem get name => _name;
  validaitonitem get address => _address;
  validaitonitem get whatsapp => _whatsapp;
  validaitonitem get email => _email;

//Controllers
  final namecontorller = TextEditingController();
  final adresscontorller = TextEditingController();

  final whatappcontroller = TextEditingController();

  final emailcontroller = TextEditingController();

  //dispsoe the controller
  void disposeControllers() {
    emailcontroller.dispose();
    adresscontorller.dispose();
    whatappcontroller.dispose();
    namecontorller.dispose();
  }

  // Name validation function
  void validateName(String value) {
    if (value.isEmpty) {
      _name = validaitonitem(value, "enter your name");
    } else {
      _name = validaitonitem(value, null);
    }
    notifyListeners();
  }

  void validateAddress(String value) {
    if (value.isEmpty) {
      _address = validaitonitem(value, "enter you address");
    } else {
      _address = validaitonitem(value, null);
    }
    notifyListeners();
  }

  void validateWhatsapp(String value) {
    if (value.isEmpty) {
      _whatsapp = validaitonitem(value, 'WhatsApp number cannot be empty');
    } else if (!value.startsWith("+92")) {
      _whatsapp = validaitonitem(value, 'WhatsApp must start with +92');
    } else {
      _whatsapp = validaitonitem(value, null);
    }

    notifyListeners();
  }

  // Email validation function
  void validateEmail(String value) {
    if (value.isEmpty) {
      _email = validaitonitem(value, "enter your email");
    } else if (!isValidEmail(value)) {
      _email = validaitonitem(value, 'Enter a valid email address');
    } else {
      _email = validaitonitem(value, null);
    }
    notifyListeners();
  }

  // Helper function to check if the email is valid
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  bool get isFormValid {
    if (_name.Value != null &&
        _address.Value != null &&
        _whatsapp.Value != null &&
        _email.Value != null) {
      return true;
    } else {
      return false;
    }
  }
}
