import 'dart:convert';
import 'dart:developer';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:member/purchasehistory.dart';
import 'package:member/userproflie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class accountpage extends StatefulWidget {
  const accountpage({Key? key}) : super(key: key);

  @override
  accountState createState() => accountState();
}

class accountState extends State<accountpage> {
  void initState() {
    super.initState();
    loadSharedPreference();
  }

  var _idMember;
  var idmember = "";
  var nama = "";
  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        var userindex = jsonDecode(prefs.getString('user')!);
        var namaindex = jsonDecode(prefs.getString('user')!);
        idmember = userindex["noBarcode"];
        nama = userindex["nama"];
      } catch (ex) {
        idmember = "";
      }

      //token = prefs.getString('token');
    });
  }

  int cc = 0;
  informasi(cc) {
    if (idmember == "") {
      showDialoghehe(context);
    } else {
      if (cc == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const userprofile()),
        );
      } else if (cc == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const purchasehistorypage()),
        );
      }
    }
  }

  getlogo() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Image.asset(
          "assets/images/logoheader.png",
          fit: BoxFit.cover,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
            backgroundColor: Colors.black,
            snap: false,
            floating: true,
            pinned: true,
            centerTitle: true,
            leading: InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('user');
                prefs.remove('idmember');
                var idmember = "";
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => StarbucksApp()));
              },
              splashColor: Colors.green,
              child: Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            ),
            title: getlogo()),
        SliverToBoxAdapter(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.all(5),
              color: Colors.black12,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.65,
                    // color: Colors.amber,
                    child: Card(
                      shadowColor: Colors.black,
                      elevation: 5,
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          showDialogFunc(context, _idMember = idmember);
                        },
                        child: Image.asset(
                          'assets/images/card.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                  // Container(
                  //   height: 60,
                  //   padding: const EdgeInsets.all(5),
                  //   child: SizedBox(
                  //     width: 150,
                  //     height: MediaQuery.of(context).size.height * 0.1,
                  //     child: TextButton(
                  //       onPressed: () {
                  //         showDialogFunc(context, _idMember = idmember);
                  //       },
                  //       child: Center(
                  //         child: Text(
                  //           'Show Barcode',
                  //           style: TextStyle(
                  //               color: Colors.green.shade600, fontSize: 15),
                  //         ),
                  //       ),
                  //       style: ButtonStyle(
                  //         shape: MaterialStateProperty.all(
                  //           RoundedRectangleBorder(
                  //             side: BorderSide(
                  //                 color: Colors.green.shade600, width: 2),
                  //             borderRadius: BorderRadius.circular(15),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (
              BuildContext context,
              int index,
            ) {
              return Column(
                children: [
                  Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: option(index)),
                  Container(
                    height: 1,
                    color: index <= 1 ? Colors.black12 : Colors.white,
                  )
                ],
              );
            },
            childCount: 10,
          ),
        )
      ],
    ));
  }

  option(menu) {
    if (menu == 0) {
      return InkWell(
        onTap: () {
          informasi(1);
        },
        child: ListTile(
          leading: Icon(
            Icons.manage_accounts,
            color: Colors.black,
          ),
          trailing: Icon(Icons.arrow_forward_ios_sharp),
          title: Text(
            "PROFILE INFORMATION",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    } else if (menu == 1) {
      return InkWell(
        onTap: () {
          informasi(2);
        },
        child: ListTile(
          leading: Icon(Icons.work_history_sharp, color: Colors.black),
          trailing: Icon(Icons.arrow_forward_ios_sharp),
          title: Text(
            "PURCHASE HISTORY",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    } else if (menu == 2) {
      // return InkWell(
      //   onTap: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => const sliderpage()),
      //     );
      //   },
      //   child: ListTile(
      //     leading: Icon(Icons.coffee, color: Colors.black),
      //     trailing: Icon(Icons.arrow_forward_ios_sharp),
      //     title: Text(
      //       "GETTING STARTED",
      //       style: TextStyle(fontSize: 18),
      //     ),
      //   ),
      // );
    } else if (menu == 9) {
      return Center(
        child: InkWell(
          onTap: () {},
          child: Container(
            child: Text(
              "Version 1.0.1",
              style: TextStyle(fontSize: 12),
            ),
          ),
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

  showDialoghehe(context) {
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
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                    child: Text("Anda Belum Login!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 103, 9, 29),
                            fontSize: 24,
                            fontFamily: 'Cabin-Medium'))),
              ),
            ),
          );
        });
  }
}
