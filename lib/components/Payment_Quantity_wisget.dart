import 'package:api_project/components/Colors.dart';
import 'package:api_project/provider/Payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:provider/provider.dart';

class Paymentwidget extends StatelessWidget {
  final String itemPrice;

  const Paymentwidget({
    super.key,
    required this.itemPrice,
  });

  @override
  Widget build(BuildContext context) {
    var paymentProvider = Provider.of<PaymentProvider>(context);

    double itemPriceDouble = double.tryParse(itemPrice) ?? 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.remove,
                  color: AppColors.white,
                ),
                onPressed: () {
                  paymentProvider.decrement();
                },
              ),
            ),
            const Gutter(),
            Text(
              '${paymentProvider.quantity}',
              style: const TextStyle(fontSize: 16),
            ),
            const Gutter(),
            Container(
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
                onPressed: () {
                  paymentProvider.increment();
                },
              ),
            ),
          ],
        ),
        const Gutter(),
        // Show Total Amount
        Row(
          children: [
            const Text(
              "Total Amount: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              "\$${paymentProvider.calculateTotal(itemPriceDouble).toStringAsFixed(2)}",
            ),
          ],
        ),
      ],
    );
  }
}
