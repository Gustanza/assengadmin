import 'dart:io';
import 'package:assengadmin/vifaa/konstants.dart';
import 'package:assengadmin/vifaa/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class PublisherPage extends StatefulWidget {
  const PublisherPage({super.key});

  @override
  State<PublisherPage> createState() => _PublisherPageState();
}

class _PublisherPageState extends State<PublisherPage> {
  List<XFile?> mapichapicha = [null];
  List<String> maurl = [];
  String? newsCat;
  bool isPublishing = false;
  final clouddbref = FirebaseFirestore.instance;
  TextEditingController titleCon = TextEditingController();
  TextEditingController descCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Create",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          SliverPadding(
              padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Choose heander photos",
                  style: TextStyle(
                      fontSize: header4font, fontWeight: FontWeight.bold),
                ),
              )),
          SliverToBoxAdapter(
            child: SizedBox(
                height: 150,
                child: Card(
                  elevation: 0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mapichapicha.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                            width: 200,
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(width: 1, color: Colors.blue)),
                            child: IconButton(
                              onPressed: imgPicker,
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                                size: 40,
                              ),
                            ));
                      }
                      return Container(
                        width: 200,
                        margin:
                            const EdgeInsets.only(left: 8, top: 12, bottom: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image:
                                    FileImage(File(mapichapicha[index]!.path)),
                                fit: BoxFit.cover)),
                      );
                    },
                  ),
                )),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
            sliver: SliverToBoxAdapter(
                child: Card(
              elevation: 0,
              child: CupertinoListTile(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                title: Text(
                  newsCat ?? "Choose category",
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                onTap: chooseCat,
              ),
            )),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
            sliver: SliverToBoxAdapter(
              child: CupertinoTextField(
                controller: titleCon,
                placeholder: "News title",
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 12, top: 8, right: 12),
            sliver: SliverToBoxAdapter(
              child: CupertinoTextField(
                controller: descCon,
                maxLines: null,
                placeholder: "News detail",
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 12, top: 16, right: 12),
            sliver: SliverToBoxAdapter(
                child: CupertinoButton.filled(
              onPressed: uploader,
              child: isPublishing
                  ? const CupertinoActivityIndicator(
                      color: Colors.white,
                    )
                  : const Text("Publish"),
            )),
          )
        ],
      ),
    );
  }

  imgPicker() async {
    XFile? picha = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picha != null) {
      setState(() {
        mapichapicha.add(picha);
      });
    }
  }

  mjumbe(String ujumbe) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ujumbe)));
  }

  checker() {
    if (mapichapicha.length == 1) {
      mjumbe("Select atleast one photo");
      return false;
    }
    if (newsCat == null) {
      mjumbe("Select news category");
      return false;
    }
    if (titleCon.text.isEmpty) {
      mjumbe("Provide a title for the news");
      return false;
    }
    if (descCon.text.isEmpty) {
      mjumbe("Provide details for the news");
      return false;
    }
    return true;
  }

  uploader() async {
    if (checker()) {
      setState(() {
        isPublishing = true;
      });
      var uuid = const Uuid();
      final storageRef = FirebaseStorage.instance.ref();
      for (var onePicha in mapichapicha) {
        try {
          final actualRef = storageRef.child("newsphotos/${uuid.v4()}");
          if (onePicha != null) {
            await actualRef.putFile(File(onePicha.path));
            final url = await actualRef.getDownloadURL();
            maurl.add(url);
          }
        } catch (err) {
          mjumbe(err.toString());
          setState(() {
            isPublishing = false;
          });
          return;
        }
      }
      print("imefika hapa");
      try {
        await clouddbref.collection(newsCol).add({
          newsPicha: maurl,
          newsKategoria: newsCat,
          newsHeading: titleCon.text,
          newsMaelezo: descCon.text,
          newsPosted: DateTime.now()
        });
        setState(() {
          isPublishing = false;
        });
        Navigator.of(context).pop();
      } catch (err) {
        setState(() {
          isPublishing = false;
        });
        mjumbe(err.toString());
      }
    }
  }

  chooseCat() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        message: const Text("SELECT NEWS CATEGORY"),
        actions: List.generate(
            catsList.length,
            (index) => CupertinoActionSheetAction(
                onPressed: () {
                  setState(() {
                    newsCat = catsList[index][maelezoYacatsList];
                  });
                  Navigator.of(context).pop();
                },
                child: Text(catsList[index][maelezoYacatsList]))),
        cancelButton: CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")),
      ),
    );
  }
}
