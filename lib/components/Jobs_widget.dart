import 'package:api_project/components/Colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class JobWidget extends StatelessWidget {
  final String imagepath;
  final String code;
  final String title;
  final String department;
  final Color jobCodeColor;

  const JobWidget({
    super.key,
    required this.imagepath,
    required this.code,
    required this.department,
    required this.jobCodeColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
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
            SizedBox(
              height: 100,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: imagepath,
                fit: BoxFit.cover,
              ),
            ),
            const Gutter(),
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Job Code",
              style: TextStyle(fontSize: 20, color: jobCodeColor),
            ),
            Text(code),
            const Gutter(),
            Text(
              "Department",
              style: TextStyle(color: jobCodeColor, fontSize: 20),
            ),
            const SizedBox(width: 4),
            Text(department),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
