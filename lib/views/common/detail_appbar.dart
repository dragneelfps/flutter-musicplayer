import 'package:flutter/material.dart';

AppBar buildDetailApp(
    {BuildContext context, String title, List<Widget> actions}) {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    title: Text(title),
    actions: actions,
  );
}
