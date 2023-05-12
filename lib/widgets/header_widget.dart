import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.yMMMMd().format(DateTime.now());
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Text(
          date,
          style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
        ));
  }
}
