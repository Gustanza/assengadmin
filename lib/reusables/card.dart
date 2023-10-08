import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardYaNews extends StatelessWidget {
  final String picha;
  final String kichwa;
  final String kategoria;
  final mudago;
  const CardYaNews(
      {super.key,
      required this.picha,
      required this.kichwa,
      required this.kategoria,
      required this.mudago});

  @override
  Widget build(BuildContext context) {
    String mudaform = DateFormat('yyyy-MM-dd').format(mudago.toDate());

    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 8, right: 8, top: 4),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(picha), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            CupertinoListTile(
              title: Text(
                kichwa,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blueGrey),
              ),
              subtitle: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "$mudaform:  ",
                        style: const TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: kategoria,
                        style: const TextStyle(
                            color: CupertinoColors.destructiveRed,
                            fontWeight: FontWeight.bold))
                  ])),
              trailing: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
            )
          ],
        ));
  }
}
