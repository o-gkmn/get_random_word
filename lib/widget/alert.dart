import 'package:flutter/material.dart';

class Alert {
  static Future<String?> alertEmptyWordsList(
      BuildContext context, String alertText) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: const Text("Kelime yok"),
        content: Text(alertText),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
