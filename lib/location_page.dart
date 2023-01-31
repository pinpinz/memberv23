import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

var titleList = [
  "Sidoarjo",
  "Surabaya",
  "Surabaya",
  "Jakarta",
  "Jakarta",
  "Bali",
  "Malang",
  "Pasuruan",
];

var descList = [
  "Komplek Industri & Pergudangan Sinar Buduran Blok B1-B6 Jl. Raya, Jalan Lingkar Timur, Gesing, Banjarsari, Kec. Sidoarjo, Kabupaten Sidoarjo, Jawa Timur 61252",
  "Jalan Dokter Ir. Haji Soekarno No.409-411, Kedung Baruk, Rungkut, Penjaringan Sari, Kec. Rungkut, Kota SBY, Jawa Timur 60298",
  "Jl. Mayjen HR. Muhammad, Pradahkalikendal, Kec. Dukuhpakis, Kota SBY, Jawa Timur 60226",
  "Ruko The Icon Business PArk Blok K No.15, Sampora, Cisauk, Tangerang",
  "Pasar modern grand wisata, Blok PR 2 No 22 (Pintu masuk utara utama),Lambang Sari, Bekasi",
  "Jl. Imam Bonjol No.515 A, Pemecutan Klod, Kec. Denpasar Bar., Kota Denpasar, Bali 80119",
  "Jl. Brigjen Slamet Riadi No.108, Oro-oro Dowo, Kec Klojen, Malang",
  "Jl. Raya Surabaya-Malang, Karangploso, Ngerong, Kec Gempol, Pasuruan",
];

var direction;

var telp = [
  "Telp : (031) 8921995",
  "Telp : (031) 99044633",
  "Telp : (031) 99147338",
  "Telp : -",
  "Telp : -",
  "Telp : (0361) 8452770",
  "Telp : (0341) 358080",
  "Telp : (0343) 636766",
];

var btn, open;

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _locationpageState createState() => _locationpageState();
}

class _locationpageState extends State<LocationPage> {
  void iniState() {
    super.initState();
  }

  getlogo() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Image.asset(
          "assets/images/logoheader.png",
          fit: BoxFit.cover,
        ));
  }

  int indexCarousel = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getlogo(),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  "STORE",
                  style: TextStyle(fontSize: 30, fontFamily: 'Cabin-Medium'),
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 4),
                      height: MediaQuery.of(context).size.height * 0.5,
                      onPageChanged: (index, reason) {
                        setState(() {
                          indexCarousel = index;
                        });
                      },
                    ),
                    items: [0, 1, 2, 3, 4, 5, 6, 7].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () {
                              showDialogFunc(context, titleList[i], descList[i],
                                  btn, telp[i], i);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/toko/toko" +
                                            i.toString() +
                                            ".png",
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lokasi(indexCarousel),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "AYO TERUS BERBELANJA NIKMATI PROMONYA DAN DAPATKAN CASHBACK POINYA. MAKIN BANYAK POIN MAKIN UNTUK BERBELANJA",
                      style: TextStyle(fontSize: 12, fontFamily: 'Avenir'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/footer.png'),
                      fit: BoxFit.fill),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

showDialogFunc(context, title, desc, btn, telp, direction) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                children: <Widget>[
                  AutoSizeText(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AutoSizeText(
                    desc,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText("Jam : 08.00 - 20.00",
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black)),
                  AutoSizeText(telp,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: MaterialButton(
                          onPressed: () {
                            _launchURL(direction);
                          },
                          child: const Text('Direction',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16)),
                          color: Color.fromARGB(255, 246, 146, 30),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: const EdgeInsets.all(5),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

_launchURL(int arr) async {
  if (arr == 0) {
    const url = 'https://goo.gl/maps/WjNz9D7VHJU238APA';
    await launch(url);
  } else if (arr == 1) {
    const url = 'https://goo.gl/maps/6oCbR2Yrq12w6dRJ8';
    await launch(url);
  } else if (arr == 2) {
    const url = 'https://goo.gl/maps/mTQEypDAMAe7vnhM6';
    await launch(url);
  } else if (arr == 3) {
    const url = 'https://goo.gl/maps/bL2GchJJMFLr7GKP6';
    await launch(url);
  } else if (arr == 4) {
    const url = 'https://goo.gl/maps/W54GshW9vCjxNQEt6';
    await launch(url);
  } else if (arr == 5) {
    const url = 'https://goo.gl/maps/hdDisD1MNw9EiGK59';
    await launch(url);
  }
}

Lokasi(lokasi) {
  if (lokasi == 0) {
    return Text(
      "Factory Shop Sidoarjo",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 1) {
    return Text(
      "Factory Shop Surabaya MER",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 2) {
    return Text(
      "Factory Shop Surabaya HR",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 3) {
    return Text(
      "Factory Shop Bsd-Serpong",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 4) {
    return Text(
      "Factory Shop Bekasi",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 5) {
    return Text(
      "Factory Shop Bali",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 6) {
    return Text(
      "Factory Shop Malang",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 7) {
    return Text(
      "Factory Shop Pasuruan",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  }
}
