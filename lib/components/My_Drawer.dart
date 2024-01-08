import 'package:api_project/components/Get_in_Touch.dart';
import 'package:api_project/model/Token.dart';
import 'package:api_project/provider/All_Deparments.dart';
import 'package:api_project/utils/RoutName.dart';
import 'package:api_project/views/User_View_Model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'colors.dart'; // Import your color constants

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderController>(context, listen: false);
    User_view_Model userModel = User_view_Model();

    return FutureBuilder<UserToken?>(
      future: userModel.getUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          String? storeLogo = snapshot.data!.storeLogo;
          return Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                    child: CachedNetworkImage(
                  imageUrl: storeLogo ?? " ",
                )),
                // const ListTile(
                //   leading: Icon(Icons.person),
                //   title: Text("Login"),
                // ),
                const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                // ... other list tile items
                const ListTile(
                  leading: Icon(Icons.home,),
                  title: Text("Home"),
                ),
                const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routesname.About_Us);
                  },
                  child: const ListTile(
                    leading: Icon(FontAwesomeIcons.person),
                    title: Text("About Us"),
                  ),
                ),
                const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routesname.Contact);
                  },
                  child: const ListTile(
                    leading: Icon(FontAwesomeIcons.phone),
                    title: Text("Contact"),
                  ),
                ),
                const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routesname.Blogs);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("Blog"),
                  ),
                ),
                const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                const ListTile(
                  leading: Icon(Icons.find_in_page),
                  title: Text("Jobs"),
                ),
                const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                const ListTile(
                  leading: Icon(FontAwesomeIcons.envelope),
                  title: Text("Offers"),
                ),
                const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                const Gutter(),

                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ... social media icons
                      SocialMediaIcon(
                        ontap: () async {
                          await provider.launchFacebookURL();
                        },
                        icon: FontAwesomeIcons.facebook,
                        color: AppColors.primaryColor,
                      ),
                      SocialMediaIcon(
                        ontap: () async {
                          await provider.launchyoutubeURL();
                        },
                        icon: FontAwesomeIcons.youtube,
                        color: AppColors.red,
                      ),
                      SocialMediaIcon(
                        ontap: () async {
                          await provider.launchinstagramURL();
                        },
                        icon: FontAwesomeIcons.instagram,
                        color: AppColors.red,
                      ),
                      SocialMediaIcon(
                        ontap: () {
                          // Handle TikTok icon tap
                        },
                        icon: FontAwesomeIcons.tiktok,
                        color: AppColors.textColor,
                      ),
                      SocialMediaIcon(
                        ontap: () {
                          // Handle Snapchat icon tap
                        },
                        icon: FontAwesomeIcons.snapchat,
                        color: AppColors.yellow,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialMediaIcon(
                        icon: FontAwesomeIcons.weixin,
                        color: AppColors.accentColor,
                        ontap: () {}),
                    SocialMediaIcon(
                        icon: FontAwesomeIcons.amazon,
                        color: AppColors.textColor,
                        ontap: () {}),
                    SocialMediaIcon(
                        icon: FontAwesomeIcons.ebay,
                        color: AppColors.textColor,
                        ontap: () {}),
                    SocialMediaIcon(
                        icon: FontAwesomeIcons.d,
                        color: Colors.orange,
                        ontap: () {}),
                    SocialMediaIcon(
                        icon: FontAwesomeIcons.o,
                        color: AppColors.accentColor,
                        ontap: () {})
                  ],
                )
              ],
            ),
          );
        } else {
          return const Center(child: Text("ERROR"));
        }
      },
    );
  }
}
