import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget{

  final String alertText;

  const CustomAlertDialog({super.key, required this.alertText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 50, right: 50),
        height: 180,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 1),
            Icon(
              Icons.warning,
              size: 48.0,
              color: Theme.of(context).colorScheme.error,
            ),
            const Spacer(flex: 1),
            Text(
              alertText,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Spacer(flex: 1),
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Kapat")),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
