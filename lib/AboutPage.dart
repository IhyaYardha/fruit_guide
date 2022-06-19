import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          //Deskripsi
          Text(
            "Tentang Aplikasi Ini:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "Aplikasi ini dibuat dengan tujuan untuk memberikan pengetahuan tentang berbagai jenis buah dan manfaat yang dimilikinya.\n"
            "Kami berharap aplikasi ini dapat membantu anda mengenal berbagai macam buah beserta manfaatnya yang mungkin belum anda ketahui sebelumnya.\n",
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10),
          Text(
            "Bila ada saran dan masukan bisa hubungi kami melalui email berikut: \n"
            "ihyayak9@gmail.com",
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
