import 'package:flutter/material.dart';

void navigateToPage(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}
