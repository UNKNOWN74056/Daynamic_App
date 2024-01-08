import 'package:api_project/components/Colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Blog_widget extends StatelessWidget {
  final imagepath;
  final String time;
  final String title;
  final String chat;
  const Blog_widget({
    super.key,
    required this.imagepath,
    required this.time,
    required this.chat,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width > 600 ? 400 : 350,
          color: AppColors.grey,
          child: CachedNetworkImage(
            imageUrl: imagepath,
            fit: BoxFit.cover,
          ),
        ),
        const Gutter(),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: [
              const Icon(
                FontAwesomeIcons.calendar,
                size: 20,
              ),
              Text(time),
              const Gutter(),
              const Icon(
                FontAwesomeIcons.message,
                size: 20,
              ),
              Text(chat),
            ],
          ),
        ),
        const Gutter(),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        const Gutter(),
      ],
    );
  }
}
