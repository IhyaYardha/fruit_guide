import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruit_guide/AboutPage.dart';
//import 'package:fruit_guide/display_favorit.dart';
import 'package:get/get.dart';
import 'detail_page.dart';
import 'display_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

int _index = 1;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference buah = firestore.collection("Buah");
    CollectionReference favorit = firestore.collection("Favorit");

    Widget titleHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Text(
              "Know better about your\n Favorite Fruits!",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }

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

    Widget Content(
        String namaBuah, imageUrl, deskripsi, manfaat, bool isFavorit) {
      return Column(
        children: [
          GestureDetector(
            child: DisplayImageItem(imageUrl: imageUrl, namaBuah: namaBuah),
            onTap: () {
              Get.to(() => DetailsPage(
                  namaBuah: namaBuah,
                  deskripsi: deskripsi,
                  imageUrl: imageUrl,
                  manfaat: manfaat,
                  isFavorit: isFavorit));
            },
          ),
        ],
      );
    }

    //HALAMAN Aplikasi
    final List<Widget> _pages = [
      ListView(
        children: [
          SizedBox(height: 35),
          FutureBuilder<QuerySnapshot>(
            future: favorit.get(),
            builder: (_, snapshot) {
              return (snapshot.hasData)
                  ? Column(
                      children: snapshot.data!.docs
                          .map(
                            (e) => Stack(
                              children: [
                                Content(
                                  e.get('nama'),
                                  e.get('gambar'),
                                  e.get('deskripsi'),
                                  e.get('manfaat'),
                                  e.get('isFavorit'),
                                ),
                                DeleteFav(e.get('nama')),
                              ],
                            ),
                          )
                          .toList(),
                    )
                  : Center(child: Text('Loading...'));
            },
          ),
        ],
      ),
      //page home
      ListView(
        children: [
          titleHeader(),
          SizedBox(height: 35),
          FutureBuilder<QuerySnapshot>(
            future: buah.get(),
            builder: (_, snapshot) {
              return (snapshot.hasData)
                  ? Column(
                      children: snapshot.data!.docs
                          .map(
                            (e) => Content(
                              e.get('nama'),
                              e.get('gambar'),
                              e.get('deskripsi'),
                              e.get('manfaat'),
                              e.get('isFavorit'),
                            ),
                          )
                          .toList(),
                    )
                  : Center(child: Text('Loading...'));
            },
          ),
        ],
      ),
      //About US
      AboutPage(),
    ];

    return Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text(
            "Fruit Guide",
            style: TextStyle(color: Colors.black),
          ),
        ),
        //Body
        body: SafeArea(
          child: Container(child: _pages.elementAt(_index)),
        ),

        //Navbar
        bottomNavigationBar: new Theme(
          data: Theme.of(context)
              .copyWith(canvasColor: Colors.yellow, primaryColor: Colors.red),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _index,
            onTap: (int index) {
              setState(() {
                _index = index;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorit"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
            ],
          ),
        ));
  }
}
