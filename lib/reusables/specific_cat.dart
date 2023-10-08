import 'package:assengadmin/reusables/card.dart';
import 'package:assengadmin/reusables/one_new.dart';
import 'package:assengadmin/vifaa/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecificCat extends StatelessWidget {
  final String catName;
  const SpecificCat({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: .5,
          title: Text(catName),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(newsCol)
              .where(newsKategoria, isEqualTo: catName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = (snapshot.data as dynamic).docs;
              if (data.isEmpty) {
                return const Center(
                  child: Text("No news in this category"),
                );
              }
              return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 300,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OneNews(onenew: data[0]),
                            ));
                          },
                          child: CardYaNews(
                            picha: data[0][newsPicha][0],
                            kategoria: data[0][newsKategoria],
                            kichwa: data[0][newsHeading],
                            mudago: data[0][newsPosted],
                          ),
                        ),
                      ),
                    ),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 12)),
                    SliverGrid.builder(
                      itemCount: data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  OneNews(onenew: data[index]),
                            ));
                          },
                          child: CardYaNews(
                            picha: data[index][newsPicha][0],
                            kategoria: data[index][newsKategoria],
                            kichwa: data[index][newsHeading],
                            mudago: data[index][newsPosted],
                          ),
                        );
                      },
                    )
                  ]);
            }
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ));
  }
}
