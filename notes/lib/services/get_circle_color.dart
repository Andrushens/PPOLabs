import 'package:flutter/material.dart';

Color getCircleColor(String label) {
  switch (label) {
    case 'Very Important':
      return Colors.red;
    case 'Important':
      return Colors.orange;
    case 'Not Very Important':
      return Colors.green;
    case 'Bruh':
      return Colors.blue;
    default:
      return Colors.red;
  }
}
