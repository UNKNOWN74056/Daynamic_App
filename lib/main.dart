import 'package:api_project/model/Token.dart';
import 'package:api_project/provider/All_Deparments.dart';
import 'package:api_project/provider/Payment_provider.dart';
import 'package:api_project/provider/Quantity_provider.dart';
import 'package:api_project/provider/Validation_provider.dart';
import 'package:api_project/services/Home_View_model.dart';
import 'package:api_project/utils/RoutName.dart';
import 'package:api_project/utils/Routes.dart';
import 'package:api_project/views/User_View_Model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserToken?>(
      future: User_view_Model().getUser(),
      builder: (BuildContext context, AsyncSnapshot<UserToken?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          String? storeTitle = snapshot.data!.storetitle;

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => ProviderController()),
              ChangeNotifierProvider(create: (context) => HomeViewModel()),
              ChangeNotifierProvider(create: (context) => ValidationProvider()),
              ChangeNotifierProvider(create: (context) => User_view_Model()),
              ChangeNotifierProvider(create: (context) => QuantityProvider()),
              ChangeNotifierProvider(create: (context) => PaymentProvider()),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                textTheme:
                    GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
                        .apply(bodyColor: Colors.black),
                pageTransitionsTheme: const PageTransitionsTheme(builders: {
                  TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                }),
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: Routesname.spalsh_screen,
              onGenerateRoute: (settings) =>
                  Routes.generateRoutes(settings, storeTitle),
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}
