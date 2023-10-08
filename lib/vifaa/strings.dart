import 'package:flutter/cupertino.dart';

// brand name
List<String> orgname = ['Assenga', 'online', '.', 'com'];
//def foto
String imgDef =
    "https://firebasestorage.googleapis.com/v0/b/assengaprime-92489.appspot.com/o/projectsoftonia%2Fpexels-chris-schippers-421927.jpg?alt=media&token=347086f8-0b70-42ee-b860-b4d5c9cafefc";
//collections news
String newsCol = "news";
//field zake
String newsPicha = "picha";
String newsKategoria = "kategoria";
String newsHeading = "kichwa";
String newsMaelezo = "maelezo";
String newsPosted = "muda";

//categories
String catsListIcon = 'icon';
String maelezoYacatsList = 'maelezo';
List<Map<String, dynamic>> catsList = [
  {catsListIcon: CupertinoIcons.news, maelezoYacatsList: "Education"},
  {catsListIcon: CupertinoIcons.sportscourt, maelezoYacatsList: "Sports"},
  {catsListIcon: CupertinoIcons.person, maelezoYacatsList: "Politics"},
  {catsListIcon: CupertinoIcons.speaker, maelezoYacatsList: "Jobs"},
  {catsListIcon: CupertinoIcons.money_dollar, maelezoYacatsList: "Finance"},
  {
    catsListIcon: CupertinoIcons.selection_pin_in_out,
    maelezoYacatsList: "Selection"
  },
  {catsListIcon: CupertinoIcons.person_3, maelezoYacatsList: "Tamisemi"},
  {catsListIcon: CupertinoIcons.star, maelezoYacatsList: "Tech"},
];
String dummytext =
    "To determine visible indexes, the scroll view needs a way to associate the generated semantics of each scrollable item with a semantic index. This can be done by wrapping the child widgets in an IndexedSemantics. This semantic index is not necessarily the same as the index of the widget in the scrollable, because some widgets may not contribute semantic information. Consider a ListView. separated every other widget is a divider with no semantic information. In this case, only odd numbered widgets have a semantic index (equal to the index ~/ 2). Furthermore, the total number of children in this example would be half the number of widgets. (The ListView.separated constructor handles this automatically; this is only used here as an example.)The total number of visible children can be provided by the constructor parameter semanticChildCount. This should always be the same as the number of widgets wrapped in IndexedSemantics.";
