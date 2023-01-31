import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:member/ecatalogue.dart';
import 'package:member/login_page.dart';
import 'package:member/location_page.dart';
import 'package:member/promolokal.dart';
import 'package:member/promonasional.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'main.dart';

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  _mainpageState createState() => _mainpageState();
}

var listData = [];

class _mainpageState extends State<mainpage> {
  YoutubePlayerController _ycontroller = YoutubePlayerController(
    initialVideoId: '8iQb6CderPA',
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
      isLive: false,
    ),
  );
  void initState() {
    // TODO: implement initState
    super.initState();

    loadSharedPreference();
  }

  Future _fetchListItems(path) async {
    var dio = Dio();
    print(ip + path);
    Response response = await dio.get(
      ip + path, //endpoint api Login
      options: Options(contentType: Headers.jsonContentType),
    );

    Map<String, dynamic> map = jsonDecode(response.data);
    //print("member 0:");
    //print("bkembalian");
    //print(map["member"]);
    List<dynamic> kembalian = [];
    try {
      kembalian = map["member"] as List<dynamic>;
    } catch (ex) {
      print("error");
      print(ex);
    }

    //#print("kembalian");
    //print(kembalian);
    // List<dynamic> kembalian = jsonDecode(response.data);
    return kembalian;
  }

  late Timer _rootTimer;

  var idmember = "";
  var nama = "";
  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        var userindex = jsonDecode(prefs.getString('user')!);
        idmember = userindex["idMember"];
      } catch (ex) {
        idmember = "";
      }

      //token = prefs.getString('token');
    });
  }

  Widget getlogin() {
    print("ISI DARI IDMEMBER");
    print(idmember);
    if (idmember != "") {
      return Text(
        '-',
        style: TextStyle(color: Colors.white, fontSize: 20),
      );
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Icon(
        //   Icons.merge_outlined,
        //   size: 25,
        //   color: Colors.black,
        // ),

        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                new MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(
                Icons.login_outlined,
                size: 25,
                color: Colors.white,
              ),
            ))
      ]);
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

  List itemList = [1, 2, 3, 4, 5];
  var tujuan = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: Icon(
          //   Icons.menu_sharp,
          //   color: Colors.white,
          // ),
          title: getlogo(),
          actions: [getlogin()],
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        drawer: const navigationdrawer(),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: SingleChildScrollView(
            // physics: ScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/home2.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                    color: Colors.white,
                    child: FutureBuilder(
                        future: _fetchListItems("gambarpromo.php"),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            );
                          } else {
                            listData = snapshot.data;
                            //print("list data");
                            //print(listData.toString());
                            //print("after list data");
                            return CarouselSlider.builder(
                              itemCount: listData.length,
                              itemBuilder:
                                  (BuildContext, int index, int jumlah) {
                                return InkWell(
                                    onTap: () {
                                      // _launchURL(1);
                                    },
                                    splashColor: Colors.redAccent,
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.84,
                                        margin: EdgeInsets.all(2),
                                        // child: Text(index.toString()),
                                        child: Card(
                                          shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Image.network(
                                            ip.toString() +
                                                "gambar/" +
                                                listData[index]["pathGambar"]
                                                    .toString(),
                                            // width: MediaQuery.of(context).size.width,
                                            fit: BoxFit.fill,

                                            errorBuilder: (BuildContext, Object,
                                                StackTrace) {
                                              return Text('Connection Error');
                                            },
                                          ),
                                        )));
                              },
                              options: CarouselOptions(
                                scrollDirection: Axis.horizontal,

                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                enlargeCenterPage: false,
                                // aspectRatio: 16 / 9,
                                autoPlay: true,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 600),
                                viewportFraction: 1,
                              ),
                            );
                          }
                        })),
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/home1.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                    // height: 200,
                    color: Colors.lightGreenAccent,
                    child: YoutubePlayer(
                        controller: _ycontroller,
                        showVideoProgressIndicator: true)),
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Column(
                                children: [
                                  Text(
                                    "SERU-SERU",
                                    style: TextStyle(
                                        fontSize: 30, fontFamily: 'BaksoSapi'),
                                  ),
                                  Text(
                                    "BARENG KAMI",
                                    style: TextStyle(
                                        fontSize: 30, fontFamily: 'BaksoSapi'),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.search,
                              size: 40,
                            )
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 30,
                              child: Image.asset(
                                "assets/images/tiktok.png",
                              )),
                          TextButton(
                            onPressed: () {
                              _launchURL(1);
                            },
                            child: Text("thefactoryshop_",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Cabin-Medium',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 30,
                              child: Image.asset(
                                "assets/images/instagram.png",
                              )),
                          TextButton(
                            onPressed: () {
                              _launchURL(2);
                            },
                            child: Text("thefactoryshop_",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Cabin-Medium',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 30,
                              child: Image.asset(
                                "assets/images/facebook.png",
                              )),
                          TextButton(
                            onPressed: () {
                              _launchURL(3);
                            },
                            child: Text("TheFactoryShop.ID",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Cabin-Medium',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 30,
                              child: Image.asset(
                                "assets/images/youtube.png",
                              )),
                          TextButton(
                            onPressed: () {
                              _launchURL(4);
                            },
                            child: Text("Bernardi The Factory Shop",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Cabin-Medium',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  color: Colors.white,
                  child: Image.asset(
                    "assets/images/footer.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class navigationdrawer extends StatelessWidget {
  const navigationdrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildheader(context),
              buildmenuitems(context),
            ],
          ),
        ),
      );
  Widget buildheader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: Color.fromARGB(255, 245, 240, 225),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                "Factory Shoppers",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )
            ],
          ),
        ),
      );

  Widget buildmenuitems(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: Icon(Icons.store_sharp),
              title: const Text(
                "Promo Nasional",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const promoNasionalpage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.local_grocery_store_sharp),
              title: const Text(
                "Promo Instore",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const promoLokalpage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.menu_book_sharp),
              title: const Text(
                "Catalog",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const katalogpage()),
                );
              },
            ),
            Divider(
              color: Colors.black54,
            )
          ],
        ),
      );
}

_launchURL(tujuan) async {
  if (tujuan == 1) {
    const url = 'https://www.tiktok.com/@thefactoryshop_?_t=8UvnwqYgfKs&_r=1';
    await launch(url);
  } else if (tujuan == 2) {
    const url = 'https://www.instagram.com/thefactoryshop_/';
    await launch(url);
  } else if (tujuan == 3) {
    const url = 'https://www.facebook.com/thefactoryshop.id';
    await launch(url);
  } else if (tujuan == 4) {
    const url = 'https://youtube.com/channel/UCCcNdYiGOCXR4cp6DLUBMuA';
    await launch(url);
  }
}
// final Uri _url = Uri.parse('https://www.thefactoryshop.co.id/');
// void _launchUrl() async {
//   if (!await launchUrl(_url)) throw 'Could not launch $_url';
//
//https://www.instagram.com/thefactoryshop_/