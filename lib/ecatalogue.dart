import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'listasset/listkatalog.dart';
import 'main.dart';

class katalogpage extends StatefulWidget {
  const katalogpage({Key? key}) : super(key: key);

  @override
  katalogState createState() => katalogState();
}

class katalogState extends State<katalogpage> {
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
          future: _fetchListItems("katalog.php?jenis=" + pilih.toString()),
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
                        color: Color.fromARGB(255, 138, 127, 111),
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

  var tujuan = "";
  // List<Product> list = List.from(products);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: getlogo(),
          leading: backbutton(),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Catalog",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ktg(context),
            katalogshow(pilihan),
            // Expanded(
            //     child: Container(
            //   padding: EdgeInsets.all(3),
            //   child: ListView.builder(
            //       padding: EdgeInsets.all(5),
            //       itemCount: list.length,
            //       itemBuilder: ((context, index) {
            //         return Container(
            //             height: MediaQuery.of(context).size.height * 0.765,
            //             margin: EdgeInsets.all(5),
            //             decoration: BoxDecoration(
            //               shape: BoxShape.rectangle,
            //               color: Colors.orange,
            //               borderRadius: BorderRadius.circular(7),
            //               image: DecorationImage(
            //                   image: AssetImage(
            //                     list[index].image!,
            //                   ),
            //                   fit: BoxFit.cover),
            //             ),
            //             child: (Text(list[index].title!)));
            //       })),
            // )),
          ],
        ));
  }

  List<String> categories = [
    "Sosis",
    "Bakso",
    "Cake",
    "Dimsum",
    "Freshmeat",
    "Instan",
    "Kaleng",
    "Sauce",
    "Slice",
    "Snack"
  ];
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
          //   print("pilihan saya adalah ......");
          //   print(pilihan);
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
