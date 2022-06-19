import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'display_item.dart';

class DisplayFavorit extends StatefulWidget {
  const DisplayFavorit({Key? key})
      : super(
          key: key,
        );

  @override
  State<DisplayFavorit> createState() => _nameState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference favorit = firestore.collection("Favorit");
CollectionReference buah = firestore.collection("Buah");

class _nameState extends State<DisplayFavorit> {
  Widget DeleteFav(String namaBuah) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        padding: EdgeInsets.all(20),
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          setState(() {
            favorit.doc(namaBuah).delete();
            buah.doc(namaBuah).update({
              "isFavorit": false,
            });
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 35),
        FutureBuilder<QuerySnapshot>(
          future: favorit.get(),
          builder: (_, snapshot) {
            return (snapshot.hasData)
                ? Column(
                    children: snapshot.data!.docs
                        .map(
                          (e) => Stack(children: [
                            DisplayImageItem(
                              imageUrl: e.get('gambar'),
                              namaBuah: e.get('nama'),
                            ),
                            DeleteFav(e.get('nama')),
                          ]),
                        )
                        .toList(),
                  )
                : Center(child: Text('Loading...'));
          },
        ),
      ],
    );
  }
}
