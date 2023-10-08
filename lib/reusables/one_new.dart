import 'package:assengadmin/vifaa/konstants.dart';
import 'package:assengadmin/vifaa/strings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OneNews extends StatelessWidget {
  final onenew;
  const OneNews({super.key, required this.onenew});

  @override
  Widget build(BuildContext context) {
    var fbj = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        foregroundColor: Colors.blueGrey,
        title: Text(
          onenew[newsKategoria],
        ),
        actions: [
          TextButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text(
                      "Delete News?",
                      style: TextStyle(color: CupertinoColors.destructiveRed),
                    ),
                    content: const Text(
                        "By Confirming delete, you will delete this piece of news permanently not to be recovered."),
                    actions: [
                      CupertinoButton(
                        onPressed: () async {
                          try {
                            await fbj
                                .collection(newsCol)
                                .doc(onenew.id)
                                .delete();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Deleted Succesfully")));
                          } catch (err) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(err.toString())));
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text(
                          "Delete",
                          style:
                              TextStyle(color: CupertinoColors.destructiveRed),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      )
                    ],
                  ),
                );
              },
              child: const Text("Delete")),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          CarouselSlider.builder(
            itemCount: onenew[newsPicha].length,
            options: CarouselOptions(
                height: 250, autoPlay: true, viewportFraction: 1),
            itemBuilder: (context, index, realIndex) {
              return SizedBox(
                width: double.infinity,
                child: Image.network(
                  onenew[newsPicha][index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          Card(
            elevation: 0,
            child: ListTile(
              title: Text(
                onenew[newsHeading],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: header2font,
                    color: Colors.blueGrey),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text(
              onenew[newsMaelezo],
              style: TextStyle(fontSize: header4font, color: Colors.blueGrey),
            ),
          )
        ],
      ),
    );
  }
}
