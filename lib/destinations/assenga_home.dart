import 'package:assengadmin/destinations/publishing.dart';
import 'package:assengadmin/reusables/brandname.dart';
import 'package:assengadmin/reusables/category.dart';
import 'package:assengadmin/reusables/one_new.dart';
import 'package:assengadmin/reusables/specific_cat.dart';
import 'package:assengadmin/reusables/card.dart';
import 'package:assengadmin/vifaa/konstants.dart';
import 'package:assengadmin/vifaa/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class AssengaHome extends StatefulWidget {
  const AssengaHome({super.key});

  @override
  State<AssengaHome> createState() => _AssengaHomeState();
}

class _AssengaHomeState extends State<AssengaHome> {
  TextEditingController searchCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PublisherPage(),
            ));
          },
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == ConnectivityResult.mobile ||
                  snapshot.data == ConnectivityResult.wifi) {
                return mainStream();
              }
              return Center(
                child: Lottie.asset('lib/vifaa/12345.json'),
              );
            }
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          },
        ));
  }

  mainStream() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(newsCol)
          .orderBy(newsPosted, descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = (snapshot.data as dynamic).docs;
          if (data.isEmpty) {
            return const Center(
              child: Text("Nothing here"),
            );
          }
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverAppBar(
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: AssengaBrand(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverToBoxAdapter(
                    child: Text(
                  'Trending News',
                  style: TextStyle(
                      fontSize: header2font,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                )),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverToBoxAdapter(
                    child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: data.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OneNews(
                                  onenew: data[index],
                                ),
                              ));
                            },
                            child: SizedBox(
                                width: 280,
                                child: CardYaNews(
                                  kategoria: data[index][newsKategoria],
                                  kichwa: data[index][newsHeading],
                                  picha: data[index][newsPicha][0],
                                  mudago: data[index][newsPosted],
                                )));
                      }),
                )),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverToBoxAdapter(
                    child: Text(
                  'Category News',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: header2font,
                      fontWeight: FontWeight.bold),
                )),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverGrid.builder(
                    itemCount: 8,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      String cat = catsList[index][maelezoYacatsList];
                      IconData icon = catsList[index][catsListIcon];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SpecificCat(catName: cat),
                          ));
                        },
                        child: SingleCat(
                          cat: cat,
                          icon: icon,
                        ),
                      );
                    }),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverToBoxAdapter(
                    child: Text(
                  'Hot News',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: header2font,
                      fontWeight: FontWeight.bold),
                )),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverFixedExtentList.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      String mudaform = DateFormat('yyyy-MM-dd')
                          .format(data[index][newsPosted].toDate());
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OneNews(onenew: data[index]),
                          ));
                        },
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data[index][newsHeading],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: header3font,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: "${data[index][newsKategoria]}: ",
                                        style: const TextStyle(
                                            color: CupertinoColors.activeBlue)),
                                    TextSpan(
                                        text: mudaform,
                                        style: const TextStyle(
                                            color:
                                                CupertinoColors.destructiveRed))
                                  ])),
                                ],
                              )),
                              const SizedBox(width: 8),
                              Container(
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            data[index][newsPicha][0]),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                        )),
                      );
                    },
                    itemExtent: 150),
              ),
            ],
          );
        }
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }
}
