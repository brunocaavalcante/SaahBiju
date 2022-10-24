import 'package:flutter/material.dart';

class WidgetUltil {
  static barWithArrowBackIos(BuildContext context, String title) {
    return AppBar(
        title: Text(title),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context, true);
            }));
  }
}
