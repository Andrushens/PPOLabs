import 'package:flutter/material.dart';

class SmthWentWrongDialog extends StatelessWidget {
  const SmthWentWrongDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(
        left: 22,
        top: 40.0,
        right: 22,
        bottom: 20.0,
      ),
      actionsPadding: const EdgeInsets.only(bottom: 20.0),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: const Text(
        'Something went wrong',
        style: TextStyle(
          fontSize: 26,
        ),
        textAlign: TextAlign.center,
      ),
      content: Icon(
        Icons.error_outline_rounded,
        size: 150,
        color: Colors.red.withOpacity(0.9),
      ),
      actions: [
        Center(
          child: MaterialButton(
            color: Colors.white,
            onPressed: Navigator.of(context).pop,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(14),
            child: const Text(
              'Okay',
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
      ],
    );
  }
}
