import 'package:assengadmin/vifaa/konstants.dart';
import 'package:assengadmin/vifaa/strings.dart';
import 'package:flutter/material.dart';

class AssengaBrand extends StatelessWidget {
  const AssengaBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: orgname[0],
          style: TextStyle(
              fontSize: header1font,
              fontWeight: FontWeight.bold,
              color: Colors.black)),
      TextSpan(
          text: orgname[1],
          style: TextStyle(
              fontSize: header1font,
              fontWeight: FontWeight.bold,
              color: Colors.blue)),
      TextSpan(
          text: orgname[2],
          style: TextStyle(
              fontSize: header1font,
              fontWeight: FontWeight.bold,
              color: Colors.black)),
      TextSpan(
          text: orgname[3],
          style: TextStyle(
              fontSize: header1font,
              fontWeight: FontWeight.bold,
              color: Colors.red))
    ]));
  }
}
