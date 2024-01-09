import 'package:api_project/components/Colors.dart';
import 'package:api_project/components/Payment_Quantity_wisget.dart';
import 'package:api_project/components/Text_Field.dart';
import 'package:api_project/model/Agent_model.dart';
import 'package:api_project/model/Items_model.dart';
import 'package:api_project/provider/All_Deparments.dart';
import 'package:api_project/provider/Validation_provider.dart';
import 'package:api_project/services/Home_View_model.dart';
import 'package:api_project/utils/Constants.dart';
import 'package:api_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Payment_page extends StatefulWidget {
  final Items_data item;
  const Payment_page({super.key, required this.item});

  @override
  State<Payment_page> createState() => _Payment_pageState();
}

class _Payment_pageState extends State<Payment_page> {
  HomeViewModel homeviewmodel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    final validateprovider =
        Provider.of<ValidationProvider>(context, listen: false);
    final provider = Provider.of<ProviderController>(context, listen: false);
    @override
    void initState() {
      super.initState();
      homeviewmodel.fetchData();
      validateprovider.disposeControllers();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const Gutter(),
                    Consumer<ValidationProvider>(
                      builder: (context, val, child) {
                        return Text_Field(
                          controller: validateprovider.namecontorller,
                          onchange: (value) {
                            validateprovider.validateName(value);
                          },
                          labeltext: "Name",
                          hinttext: "Like Mahran Khan",
                          errorttext: val.name.error,
                        );
                      },
                    ),
                    const Gutter(),
                    Consumer<ValidationProvider>(
                      builder: (context, value, child) {
                        return Text_Field(
                          controller: validateprovider.adresscontorller,
                          onchange: (val) {
                            validateprovider.validateAddress(val);
                          },
                          labeltext: "Delivery Address",
                          hinttext: "House#, Street#, Sector, and City Name",
                          errorttext: value.address.error,
                        );
                      },
                    ),
                    const Gutter(),
                    Consumer<ValidationProvider>(
                      builder: (context, value, child) {
                        return Text_Field(
                          controller: validateprovider.whatappcontroller,
                          onchange: (val) {
                            validateprovider.validateWhatsapp(val);
                          },
                          labeltext: "Whatsapp with country code",
                          hinttext: "Like +921234567...",
                          errorttext: value.whatsapp.error,
                        );
                      },
                    ),
                    const Gutter(),
                    Consumer<ValidationProvider>(
                      builder: (context, value, child) {
                        return Text_Field(
                          controller: validateprovider.emailcontroller,
                          onchange: (val) {
                            validateprovider.validateEmail(val);
                          },
                          labeltext: "Email",
                          hinttext: "Like Mahran@gmail.com",
                          errorttext: value.email.error,
                        );
                      },
                    ),
                    const Gutter(),
                    //DROP DOWN MENU SECTION
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.blueAccent), // Outline border color
                        borderRadius: BorderRadius.circular(
                            8), // Optional: Add border radius
                      ),
                      child: Consumer<ProviderController>(
                        builder: (context, value, child) {
                          return DropdownButton(
                            value: value.selectedpayment,
                            items: value.options.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (val) {
                              value.setSelectedpayment(val!);
                            },
                          );
                        },
                      ),
                    ),

                    const Gutter(),
                    // QUANTITY WIDGET SECTION
                    Paymentwidget(
                      itemPrice: widget.item.itemPrice ?? "",
                    ),
                    const Gutter(),

                    //SHOW TOTAL PRICE
                    const Row(
                      children: [
                        Text(
                          "Total Amout : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        // Consumer<>(
                        //   builder: (context, value, child) {
                        //     int quantity = value.quantity;
                        //     double itemPrice = double.tryParse(
                        //             widget.item.itemPrice ?? "0.0") ??
                        //         0.0;

                        //     // Calculate the total amount based on the quantity
                        //     double totalAmount = itemPrice * quantity;

                        //     return Text(
                        //  "\$${totalAmount.toStringAsFixed(2)}",
                        //     );
                        //   },
                        // ),
                      ],
                    ),

                    //CHECKBOX SECTION
                    const Gutter(),
                    Consumer<ProviderController>(
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            Checkbox(
                                value: value.firstValue,
                                onChanged: (val) {
                                  value.firstValue = val!;
                                }),
                            const Text("Lease"),
                          ],
                        );
                      },
                    ),
                    Consumer<ProviderController>(
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            Checkbox(
                                value: value.secondvalue,
                                onChanged: (val) {
                                  value.secondValue = val!;
                                }),
                            const Text("Cash")
                          ],
                        );
                      },
                    ),
                    const Gutter(),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Set the border radius to 0 for a square shape
                        ),
                        backgroundColor: AppColors.purple,
                        foregroundColor: AppColors.white,
                      ),
                      label: const Text(
                        "Order Now",
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.cartShopping,
                      ),
                      onPressed: () {},
                    ),
                    const Gutter(),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Set the border radius to 0 for a square shape
                        ),
                        backgroundColor: AppColors.accentColor,
                        foregroundColor: AppColors.white,
                      ),
                      label: const Text(
                        "WhatsApp",
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.whatsapp,
                      ),
                      onPressed: () async {
                        if (!validateprovider.isFormValid) {
                          utils.Show_Flushbar_Error_Message(
                              "Please enter your field", context);
                        } else {
                          String name = validateprovider.namecontorller.text;
                          String address =
                              validateprovider.adresscontorller.text;
                          String whatsapp =
                              validateprovider.whatappcontroller.text;
                          String email = validateprovider.emailcontroller.text;

                          String defaultWhatsAppMessage =
                              "Name: $name\nAddress: $address\nWhatsApp: $whatsapp\nEmail: $email";

                          await provider.whatapplunch(
                              message: defaultWhatsAppMessage);
                        }
                      },
                    ),
                    const Gutter(),
                  ],
                ),
              ),
              const Gutter(),

              // AGENT WORK SECTION
              SizedBox(
                height: 350,
                width: double.infinity,
                child: ChangeNotifierProvider<HomeViewModel>(
                  create: (BuildContext context) => homeviewmodel,
                  child: Consumer<HomeViewModel>(
                    builder: (context, value, child) {
                      final List<Agents_data> agentList =
                          value.agentList.data ?? [];
                      final List<int> shuffledIndices =
                          List.generate(agentList.length, (index) => index)
                            ..shuffle();

                      return PageView.builder(
                        itemCount: shuffledIndices.isNotEmpty ? 1 : 0,
                        itemBuilder: (BuildContext context, int pageIndex) {
                          if (shuffledIndices.isNotEmpty) {
                            final int index = shuffledIndices[pageIndex];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: Image.network(imagespath +
                                          (agentList[index].agentPhoto1 ?? "")),
                                    ),
                                    const Gutter(),
                                    Text(
                                      "Contact Our Agent# ${agentList[index].agentName ?? ""}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: AppColors.purple),
                                    ),
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 65, right: 40),
                                        child: Text(
                                          "Contact me for any kind of gaming details you want!",
                                          style: TextStyle(fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    const Gutter(),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        backgroundColor: AppColors.accentColor,
                                        foregroundColor: AppColors.white,
                                      ),
                                      label: const Text("WhatsApp"),
                                      icon:
                                          const Icon(FontAwesomeIcons.whatsapp),
                                      onPressed: () async {
                                        await provider.launchwhatsappURL();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                                child: Text("Sorry! No agents available"));
                          }
                        },
                      );
                    },
                  ),
                ),
              ),

              const Gutter(),
            ],
          ),
        ),
      ),
    );
  }
}
