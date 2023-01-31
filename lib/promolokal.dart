import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class promoLokalpage extends StatefulWidget {
  const promoLokalpage({Key? key}) : super(key: key);

  @override
  promoLokalState createState() => promoLokalState();
}

class promoLokalState extends State<promoLokalpage> {
  void initState() {
    super.initState();
  }

  var listData = [];
  getlogo() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Image.asset(
          "assets/images/logoheader.png",
          fit: BoxFit.cover,
        ));
  }

  backbutton() {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_sharp));
  }

  Future _fetchListItems(path) async {
    var dio = Dio();
    print(ip + path);
    Response response = await dio.get(
      ip + path, //endpoint api Login
      // options: Options(contentType: Headers.jsonContentType),
    );
    print(response.data);
    Map<String, dynamic> map = jsonDecode(response.data);
    List<dynamic> kembalian = map["member"];
    // List<dynamic> kembalian = jsonDecode(response.data);
    return kembalian;
  }

  var check = "1";
  var pilih;
  Widget katalogshow(pilih) {
    if (check == "1") {
      return Expanded(
        child: FutureBuilder(
          future: _fetchListItems("promolokal.php?jenis=" + pilih.toString()),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              listData = snapshot.data;
              return ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.765,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(255, 228, 220, 208),
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                            image: NetworkImage(
                              ip.toString() +
                                  "gambar/" +
                                  listData[index]["pathGambar"].toString(),
                            ),
                            fit: BoxFit.cover),
                      ),
                    );
                  }));
            }
          },
        ),
      );
    } else {
      return Center(
        heightFactor: 5,
        child: Text(
          "- Anda Belum Login -",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  List<String> categories = [
    "Sidoarjo - Buduran",
    "Surabaya - Merr",
    "Surabaya - HR Muhammad",
    "Denpasar - Imam Bonjol",
    "Pasuruan - Gempol",
    "Malang - Oro-Oro Dowo",
    "Bekasi - Tambun Selatan",
    "Tangerang - Serpong",
  ];
  var tujuan = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: getlogo(),
          leading: backbutton(),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 103, 9, 29),
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgroundasd.jpeg'),
                fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Promo Lokal",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DropdownButton(
                    hint: Text('Please choose a location'),
                    iconEnabledColor: Color.fromARGB(255, 103, 9, 29),
                    iconSize: 30,
                    items: categories.map((categories) {
                      return DropdownMenuItem(
                        child: new Text(categories),
                        value: categories,
                      );
                    }).toList(),
                    value: pilihan,
                    onChanged: (newValue) {
                      setState(() {
                        pilihan = newValue;
                      });
                      print("Pilihan saya ...");
                      print(pilihan);
                    },
                  )
                ],
              ),
              // ktg(context),
              katalogshow(pilihan),
            ],
          ),
        ));
  }

  int indexkepilih = 0;
  Widget ktg(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => buildCategory(index),
      ),
    );
  }

  var pilihan;
  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          indexkepilih = index;
          pilihan = categories[index].toLowerCase();
          print("pilihan saya adalah ......");
          print(pilihan);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categories[index],
              style: TextStyle(
                  color: indexkepilih == index ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
