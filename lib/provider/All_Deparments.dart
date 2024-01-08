import 'package:api_project/model/Items_model.dart';
import 'package:api_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderController extends ChangeNotifier {
  //SETTER

  late Items_data _selectedItem;
  String? _selectedpayment = 'USDT';
  late String? videoUrl;
  bool _firstValue = false;
  bool _secondvalue = false;
  String? mapUrl;

  //GETTERS
  bool get firstValue => _firstValue;
  bool get secondvalue => _secondvalue;
  String? get selectedpayment => _selectedpayment;
  Items_data get selectedItem => _selectedItem;

  void setSelectedItem(Items_data newItem) {
    _selectedItem = newItem;
    notifyListeners();
  }

  final List<String> options = [
    'USDT',
    'BTC',
    'Easy Paisa',
    'Jazz Cash',
  ];

  setSelectedpayment(String value) {
    _selectedpayment = value;
    notifyListeners();
  }

  void setVideoUrl(String url) {
    videoUrl = url;
    notifyListeners();
  }

  Color getColorFromName(String color) {
    if (color.startsWith("#")) {
      // Handle hex color string
      try {
        return Color(int.parse(color.substring(1), radix: 16) + 0xFF000000);
      } catch (e) {
        // Handle invalid hex color
        print("Invalid hex color: $color");
        return Colors.black;
      }
    } else {
      // Handle color name string
      switch (color.toLowerCase()) {
        case 'orangered':
          return const Color(0xFFFF4500);
        // Add more cases for other color names as needed
        default:
          return Colors.black; // Default color if the name is not recognized
      }
    }
  }

  set firstValue(bool value) {
    _firstValue = value;
    notifyListeners();
  }

  set secondValue(bool value) {
    _secondvalue = value;
    notifyListeners();
  }

  Future<void> extractMapUrl(String mapContent) async {
    final RegExp regExp = RegExp(r'src="([^"]+)"');
    final Iterable<RegExpMatch> matches = regExp.allMatches(mapContent);

    // Provide a default value or make mapUrl nullable
    if (matches.isNotEmpty) {
      final String match = matches.first.group(1)!;

      // In this case, the match already contains the map URL
      mapUrl = match;
    } else {
      mapUrl = null; // or some default URL if needed
    }

    notifyListeners();
  }

  Future<void> extractVideoUrl(String itemVideo) async {
    final RegExp regExp = RegExp(r'src="([^"]+)"');
    final Iterable<RegExpMatch> matches = regExp.allMatches(itemVideo);

    // Provide a default value or make videoUrl nullable
    if (matches.isNotEmpty) {
      final String match = matches.first.group(1)!;
      videoUrl = match;
    } else {
      videoUrl = null; // or some default URL if needed
    }

    notifyListeners();
  }

  Future<void> launchFacebookURL() async {
    const facebookURL =
        'https://web.facebook.com/Gamezone44/?_rdc=1&_rdr'; // Replace with your Facebook page URL
    final Uri facebookUri = Uri.parse(facebookURL);
    if (await canLaunchUrl(facebookUri)) {
      await launchUrl(facebookUri);
    } else {
      utils.showToastMessage("Could not load the page!");
    }
  }

  Future<void> launchinstagramURL() async {
    const instagrameURL =
        'https://www.instagram.com/gamezonesajid/'; // Replace with your Facebook page URL
    final Uri instagramUri = Uri.parse(instagrameURL);
    if (await canLaunchUrl(instagramUri)) {
      await launchUrl(instagramUri);
    } else {
      utils.showToastMessage("Could not load the page!");
    }
  }

  Future<void> launchyoutubeURL() async {
    const youtubeURL =
        'https://www.youtube.com/@gamezonesajid1150'; // Replace with your Facebook page URL
    final Uri youtubeUri = Uri.parse(youtubeURL);
    if (await canLaunchUrl(youtubeUri)) {
      await launchUrl(youtubeUri);
    } else {
      utils.showToastMessage("Could not load the page!");
    }
  }

  Future<void> launchwhatsappURL() async {
    const whatsappURL =
        'https://api.whatsapp.com/send/?phone=%2B923339688283&text=Website+Support+Inquery&type=phone_number&app_absent=0'; // Replace with your Facebook page URL
    final Uri whatsappUri = Uri.parse(whatsappURL);
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      utils.showToastMessage("Could not load the page!");
    }
  }
}
