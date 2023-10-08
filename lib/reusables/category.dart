import 'package:flutter/material.dart';

class SingleCat extends StatelessWidget {
  final String cat;
  final IconData icon;
  const SingleCat({super.key, required this.cat, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          Text(
            cat,
            style: TextStyle(color: Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }
}
