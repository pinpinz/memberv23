import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:member/passwordupdate.dart';
import 'main.dart';
import 'main_page.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

var listData = [];

class userprofile extends StatefulWidget {
  const userprofile({Key? key}) : super(key: key);

  @override
  userprofileState createState() => userprofileState();
}

var _idMember;
var totalp;
var indox = 0;

class userprofileState extends State<userprofile> {
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPreference();
  }

  var username = "";
  var passw = "";
  var pin = "";
  var idmember = "";
  var nama = "";
  var _alamat = "";
  var hp = "";
  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        var userindex = jsonDecode(prefs.getString('user')!);
        var namaindex = jsonDecode(prefs.getString('user')!);
        idmember = userindex["idMember"];
        nama = namaindex["nama"];
        _alamat = userindex["alamat"];
        hp = userindex["hp"];
        username = userindex["username"];
        passw = userindex["pass"];
        pin = userindex["pin"];
      } catch (ex) {
        idmember = "";
      }

      //token = prefs.getString('token');
    });
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
            color: Colors.grey,
          ),
        ),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "ID : " + idmember,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "NAMA : " + nama,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "HP : " + hp,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Alamat : " + _alamat,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "USERNAME : " + username,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
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
                borderRadius: BorderRadius.circular(2),
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
