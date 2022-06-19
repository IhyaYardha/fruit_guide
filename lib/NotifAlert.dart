import 'package:flutter/material.dart';
import 'package:fruit_guide/home.dart';
import 'package:get/get.dart';

Future<dynamic> NotifAlert(BuildContext context, String pesan) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Favorit"),
          content: Text(pesan),
          actions: [
            TextButton(
                onPressed: () {
                  Get.offAll(Home());
                },
                child: Text("OK"))
          ],
        );
      });
}
