import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:member/listasset/nasionalassets.dart';
import 'listasset/listkatalog.dart';
import 'main.dart';

class promoNasionalpage extends StatefulWidget {
  const promoNasionalpage({Key? key}) : super(key: key);

  @override
  promoNasionalState createState() => promoNasionalState();
}

class promoNasionalState extends State<promoNasionalpage> {
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgroundasd.jpeg'),
                fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Promo Nasional",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              katalogshow(),
            ],
          ),
        ));
  }
}
