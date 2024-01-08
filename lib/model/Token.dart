class UserToken {
  String? storeLogo; // Add this line to include store logo information
  String? storetitle;

  UserToken({this.storeLogo, required this.storetitle});

  UserToken.fromJson(Map<String, dynamic> json) {
    storeLogo = json['storeLogo']; // Add this line to parse store logo
    storetitle = json['storetitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['storeLogo'] =
        storeLogo; // Add this line to include store logo in JSON
    data['storetitle'] = storetitle;
    return data;
  }
}
