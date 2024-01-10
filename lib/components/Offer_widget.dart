import 'package:api_project/components/Colors.dart';
import 'package:api_project/data/Responces/Status.dart';
import 'package:api_project/provider/All_Deparments.dart';
import 'package:api_project/services/Home_View_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Offer_widget extends StatefulWidget {
  const Offer_widget({super.key});

  @override
  State<Offer_widget> createState() => _Offer_widgetState();
}

class _Offer_widgetState extends State<Offer_widget> {
  HomeViewModel homeViewModel = HomeViewModel();
  @override
  void initState() {
    homeViewModel.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offers"),
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => homeViewModel,
        child: Consumer<HomeViewModel>(builder: (context, value, child) {
          if (value.storelist.status == Status.LOADING) {
            return const Center(
              child: SpinKitThreeBounce(
                color: AppColors.primaryColor,
                size: 50.0,
              ),
            );
          } else if (value.storelist.status == Status.ERROR) {
            return const Center(
              child: Text("Error loading data"),
            );
          } else if (value.storelist.status == Status.COMPLETED) {
            final store = value.storelist.data!;
            return Column(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        provider.getColorFromName(store.s66 ?? ""),
                        Colors.black,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Latest offers in market",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: SpinKitThreeBounce(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        }),
      ),
    );
  }
}
