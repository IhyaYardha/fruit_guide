import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_guide/NotifAlert.dart';
import 'package:fruit_guide/display_favorit.dart';
import 'package:get/get.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {Key? key,
      required this.namaBuah,
      required this.deskripsi,
      required this.manfaat,
      required this.imageUrl,
      required this.isFavorit})
      : super(key: key);

  final String namaBuah, deskripsi, imageUrl, manfaat;
  final bool isFavorit;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference favorit = firestore.collection("Favorit");
CollectionReference buah = firestore.collection("Buah");

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;

    //Widget untuk deskripsi
    Widget textDetails() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Nama Buah
            Row(
              children: [
                Text(
                  widget.namaBuah,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  icon: (widget.isFavorit)
                      ? Icon(Icons.star)
                      : Icon(Icons.star_border),
                  onPressed: () {
                    setState(() {
                      favorit.doc(widget.namaBuah).set({
                        "nama": widget.namaBuah,
                        "gambar": widget.imageUrl,
                        "manfaat": widget.manfaat,
                        "deskripsi": widget.deskripsi,
                        "isFavorit": true,
                      });
                      if (widget.isFavorit == true) {
                        // favorit.doc(widget.namaBuah).delete();
                        // NotifAlert(context, "Berhasil Dihapus dari Favorit");
                        // buah.doc(widget.namaBuah).update({
                        //   "isFavorit": false,
                        // });
                      } else {
                        NotifAlert(
                            context, "Berhasil Ditambahkan ke Favorit");
                        buah.doc(widget.namaBuah).update({
                          "isFavorit": true,
                        });
                      }
                      ;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 30),

            //Deskripsi
            Text(
              "Deskripsi",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              widget.deskripsi,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 30),

            //Manfaat
            Text(
              "Manfaat",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              widget.manfaat,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );
    }

    //Menampilkan
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("Fruit Guide"),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              height: tinggi / 1.5,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            ListView(
              children: [
                SizedBox(height: tinggi / 1.8),
                textDetails(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
