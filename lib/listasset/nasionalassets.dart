import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

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
var listData = [];
Widget katalogshow() {
  if (check == "1") {
    return Expanded(
      child: FutureBuilder(
        future: _fetchListItems("promonasional.php"),
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
