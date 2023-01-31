import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'main_page.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

var listData = [];

class purchasehistorypage extends StatefulWidget {
  const purchasehistorypage({Key? key}) : super(key: key);

  @override
  purchasehistoryState createState() => purchasehistoryState();
}

var username;
var _idMember;
var totalp;
var indox = 0;

class purchasehistoryState extends State<purchasehistorypage> {
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPreference();
  }

  var idmember = "";
  var nama = "";
  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        var userindex = jsonDecode(prefs.getString('user')!);
        var namaindex = jsonDecode(prefs.getString('user')!);
        idmember = userindex["idMember"];
        nama = userindex["nama"];
      } catch (ex) {
        idmember = "";
      }

      //token = prefs.getString('token');
    });
  }

  getlogo() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Image.asset(
          "assets/images/logoheader.png",
          fit: BoxFit.cover,
        ));
  }

  Widget getNama() {
    if (idmember == "") {
      return Container(
          child: Text(
        "The Factory Shop Virtual Member",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ));
    } else {
      return Container(
          child: Text(
        "Hello " + nama,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ));
    }
  }

  Widget totalPoin() {
    if (idmember == "") {
      return Container(
        child: Text(""),
      );
    } else {
      return FutureBuilder(
        future: _fetchListItems(idmember, "checktotalpoin.php?memberid="),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text("Total Poin Tidak Ada"));
          } else {
            listData = snapshot.data;
            return Text(
              "Total Poin Anda : " + listData[0]["poin"].toString(),
              style: TextStyle(fontSize: 18),
            );
          }
        },
      );
    }
  }

  exppoin() {
    if (idmember == "") {
      return Container(
        child: Text(""),
      );
    } else {
      return FutureBuilder(
        future: _fetchListItems(idmember, "expPoin.php?memberid="),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            Center(child: Text("Tidak Ada Expired Poin"));
          } else if (snapshot.hasData != null) {
            listData = snapshot.data;
            if (listData[0]["poin"].toString() == "0") {
              Column(
                children: [
                  Text(
                    "Tidak ada poin yang akan Expired",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              );
            } else {
              Column(
                children: [
                  Text(
                    "Poin Anda : " + listData[0]["poin"].toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Expired pada : " + listData[0]["tglJual"].toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              );
            }
          }
          return Column();
        },
      );
    }
  }

  Future _fetchListItems(idmember, path) async {
    var dio = Dio();
    print(ip + path + idmember);
    Response response = await dio.get(
      ip + path + idmember, //endpoint api Login
      // options: Options(contentType: Headers.jsonContentType),
    );
    print(response.data);
    Map<String, dynamic> map = jsonDecode(response.data);
    List<dynamic> kembalian = map["member"];
    // List<dynamic> kembalian = jsonDecode(response.data);
    return kembalian;
  }

  Widget checklogin() {
    // print("isi dari : ");
    // print(listData[2]["statPoin"].toString());
    if (idmember != "") {
      return Expanded(
        child: FutureBuilder(
          future: _fetchListItems(idmember, "member.php?memberid="),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              listData = snapshot.data;
              return ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      splashColor: Color.fromARGB(197, 133, 214, 136),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Material(
                            color: Color.fromARGB(66, 158, 158, 158),
                            child: Column(
                              children: [
                                if (listData[index]["statPoin"].toString() ==
                                    "Aktif") ...[
                                  ListTile(
                                      tileColor:
                                          Color.fromARGB(120, 154, 218, 157),
                                      title: Column(children: [
                                        Text(listData[index]["tglJual"]
                                            .toString()),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Lokasi = " +
                                                listData[index]["lokasi"]
                                                    .toString()),
                                            Text("Poin didapat : " +
                                                listData[index]["poin"]
                                                    .toString()),
                                          ],
                                        )
                                      ])),
                                ] else ...[
                                  ListTile(
                                      tileColor:
                                          Color.fromARGB(232, 236, 116, 116),
                                      title: Column(children: [
                                        Text(listData[index]["tglJual"]
                                            .toString()),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text("Lokasi = " +
                                                listData[index]["lokasi"]
                                                    .toString()),
                                            Text("Jumlah Poin = " +
                                                listData[index]["poin"]
                                                    .toString()),
                                          ],
                                        )
                                      ])),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          splashColor: Colors.green,
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: getlogo(),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          totalPoin(),
          exppoin(),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'History',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              color: Colors.white,
            ),
          ),
          checklogin(),
        ],
      ),
    );
  }
}

showDialogFunc(context, _idMember) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 1,
              height: 250,
              child: Column(
                children: [
                  if (_idMember == "") ...[
                    BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: "-",
                      height: 200,
                      width: 350,
                    ),
                  ] else ...[
                    BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: _idMember,
                      height: 200,
                      width: 350,
                    ),
                  ]
                ],
              ),
            ),
          ),
        );
      });
}
