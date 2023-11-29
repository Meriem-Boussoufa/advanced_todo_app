import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    Key? key,
    required this.playload,
  }) : super(key: key);
  final String playload;
  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _playload = '';

  @override
  void initState() {
    super.initState();
    _playload = widget.playload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
          ),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: context.theme.colorScheme.background,
        title: Text(
          _playload.toString().split('|')[1],
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Hello, Meriem',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Get.isDarkMode ? Colors.white : darkGreyClr,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'You have a new reminder',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: primaryClr,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.text_format,
                          size: 30,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Title',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _playload.toString().split('|')[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(
                          Icons.description,
                          size: 35,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _playload.toString().split('|')[1],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 35,
                          color: Colors.white,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      _playload.toString().split('|')[2],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            )),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
