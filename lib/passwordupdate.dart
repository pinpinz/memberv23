import 'dart:async';
import 'dart:ffi';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'main.dart';
import 'main_page.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

var listData = [];

class userpassword extends StatefulWidget {
  const userpassword({Key? key}) : super(key: key);

  @override
  userpassState createState() => userpassState();
}

var _idMember;
var totalp;
var indox = 0;

class userpassState extends State<userpassword> {
  final username1Controller = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();
  final pin1Controller = TextEditingController();
  late bool obscureText1, obscureText2, obscureText3;

  String currentText = "";

  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController textEditingController = TextEditingController();

  void initState() {
    // TODO: implement initState
    obscureText1 = true;
    obscureText2 = true;
    obscureText3 = true;
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

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  updateuser() async {
    var dio = Dio();
    print("id member " + idmember.toString());
    print("username " + username1Controller.text);
    print("password1 " + password1Controller.text);
    print("pin " + pin1Controller.text);

    var paramIDMember = Uri.encodeComponent(idmember.toString());
    var paramUsername = Uri.encodeComponent(username1Controller.text);
    var paramPassword = Uri.encodeComponent(password1Controller.text);
    var paramPin = Uri.encodeComponent(pin1Controller.text);
    var url = ip +
        "updatepassword.php?idmember=" +
        paramIDMember +
        "&username=" +
        paramUsername +
        "&password=" +
        paramPassword +
        "&pin=" +
        paramPin;
    print("url " + url);
    Response response = await dio.get(
      url, //endpoint api Login
      // options: Options(contentType: Headers.jsonContentType),
    );
    var hasil = jsonDecode(response.data);
    print("found " + hasil["hasil"].toString());
    if (pin1Controller.text.toString().length < 6) {
      showupdateuser(context, 5);
    } else {
      if (password1Controller.text.toString() !=
          password2Controller.text.toString()) {
        showupdateuser(context, 4);
      } else {
        if (hasil["hasil"].toString() == "pin terlalu mudah") {
          showupdateuser(context, 1);
        } else if (hasil["hasil"].toString() == "password terlalu mudah") {
          showupdateuser(context, 2);
        } else if (hasil["hasil"].toString() == "usernamesudahada") {
          showupdateuser(context, 3);
        } else if (hasil["hasil"].toString() == "ok") {
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Update Berhasil'),
                backgroundColor: Colors.green,
              ),
            );
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StarbucksApp()),
          );
        }
      }
    }

    /*
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StarbucksApp()),
    );*/
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
                    "Username: ",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: '...',
                      border: InputBorder.none,
                      // contentPadding: EdgeInsets.all(8),
                    ),
                    controller: username1Controller,
                    keyboardType: TextInputType.name,
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Password: ",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: '...',
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.all(8),
                        ),
                        controller: password1Controller,
                        keyboardType: TextInputType.name,
                        obscureText: obscureText1,
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: !obscureText1
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText1 = !obscureText1;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Konfirmasi",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                          Text(
                            "Password: ",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: '...',
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.all(8),
                        ),
                        controller: password2Controller,
                        keyboardType: TextInputType.name,
                        obscureText: obscureText2,
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: !obscureText2
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText2 = !obscureText2;
                      });
                    },
                  ),
                )
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
                    "Pin : ",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: TextFormField(
                    maxLength: 6,
                    decoration: const InputDecoration(
                      hintText: '...',
                      border: InputBorder.none,
                      // contentPadding: EdgeInsets.all(8),
                    ),
                    controller: pin1Controller,
                    keyboardType: TextInputType.number,
                    obscureText: obscureText3,
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: !obscureText3
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText3 = !obscureText3;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                margin: const EdgeInsets.all(25),
                width: MediaQuery.of(context).size.width * 0.45,
                child: MaterialButton(
                  onPressed: () {
                    /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StarbucksApp()),
                    );*/
                    updateuser();
                  },
                  child: const Text("Update",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16)),
                  color: Colors.green,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: const EdgeInsets.all(16),
                )),
          ])
        ],
      ),
    );
  }

  var hasil;
  showDialogFunc(context) {
    return showDialog(
        context: context,
        builder: (context) {
          hasil = 0;
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
                    Text(
                      "Enter Pin Number",
                      style: TextStyle(fontFamily: "BaksoSapi", fontSize: 20),
                    ),
                    Text(
                      "Masukan Pin Lama anda",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      controller: pin1Controller,
                      onChanged: (value) {
                        print(value);
                        hasil += 1;
                        print(hasil + "ko");
                      },
                      obscuringWidget: Icon(Icons.abc),
                      blinkDuration: const Duration(seconds: 10000),
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.circle,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    TextButton(
                        onPressed: () {
                          if (hasil == 6) {
                            print("Valid");
                            Navigator.pop(context);
                          } else {
                            print("Tidak Valid");
                          }
                        },
                        child: Text("check"))
                  ],
                ),
              ),
            ),
          );
        });
  }
}

showupdateuser(context, kode) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.orange,
              ),
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 0.80,
              height: MediaQuery.of(context).size.height * 0.13,
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    if (kode == 1) ...[
                      Text(
                        "Pin Terlalu Mudah",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'BaksoSapi'),
                      ),
                    ] else if (kode == 2) ...[
                      Text(
                        "password Terlalu Mudah",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'BaksoSapi'),
                      ),
                    ] else if (kode == 3) ...[
                      Text(
                        "USERNAME Sudah Ada",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'BaksoSapi'),
                      ),
                    ] else if (kode == 4) ...[
                      Text(
                        "Validasi Password Tidak Sama",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'BaksoSapi'),
                      ),
                    ] else if (kode == 5) ...[
                      Text(
                        "Pin Harus 6 Angka",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'BaksoSapi'),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
