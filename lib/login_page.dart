import 'dart:convert';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:member/passwordupdate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:member/main.dart';
import 'package:member/main_page.dart';
import 'package:simple_animations/simple_animations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late bool obscureText;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    obscureText = true;
  }

  Future bunyi() async {
    AudioPlayer player = AudioPlayer();
    String audioasset = "assets/audio/yes.wav";
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await player.playBytes(soundbytes);
    if (result == 1) {
      //play success
      print("Sound playing successful.");
    } else {
      print("Error while playing sound.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/login/header1.jpg'),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              width: 350,
              alignment: AlignmentDirectional.bottomStart,
              padding: EdgeInsets.all(5),
              child: Text(
                "HI FACTORY SHOPPERS,",
                style: TextStyle(fontSize: 18, fontFamily: 'BaksoSapi'),
              ),
            ),
            Container(
              width: 350,
              alignment: AlignmentDirectional.bottomStart,
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text("Sign in to continue",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.87,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: <Widget>[
                  Container(
                    child: Material(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        elevation: 2,
                        child: Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.people_sharp),
                              fillColor: Color.fromARGB(255, 245, 240, 225),
                              filled: true,
                              label: Text("username"),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(2),
                            ),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        )),
                  ),
                ])),
            SizedBox(
              height: 15,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.87,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Material(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    elevation: 2,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Center(
                              child: TextFormField(
                            textAlign: TextAlign.start,
                            decoration: const InputDecoration(
                              label: Text("password"),
                              prefixIcon: Icon(Icons.lock_open_rounded),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(2),
                              fillColor: Color.fromARGB(255, 245, 240, 225),
                              filled: true,
                            ),
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            obscureText: obscureText,
                          )),
                        ),
                        Container(
                          color: Color.fromARGB(255, 245, 240, 225),
                          child: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: !obscureText
                                  ? Colors.black.withOpacity(0.3)
                                  : Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        )
                      ],
                    ))),

            Container(
                width: 350,
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                    onPressed: () {
                      showDialogFunc(context);
                    },
                    child: Text("Forgot Password! ",
                        style: TextStyle(fontSize: 13)))),

            Container(
                margin: const EdgeInsets.only(top: 25),
                width: MediaQuery.of(context).size.width * 0.65,
                child: MaterialButton(
                  onPressed: () {
                    loginValidation(context);
                  },
                  child: const Text("Sign In",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                  color: Colors.black,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  padding: const EdgeInsets.all(10),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.15,
            ),
            Container(
                width: 350,
                alignment: AlignmentDirectional.center,
                child: Text("Don't have an account yet?",
                    style:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
            Container(
                margin: const EdgeInsets.only(top: 1),
                width: MediaQuery.of(context).size.width * 0.65,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StarbucksApp()),
                    );
                  },
                  child: const Text("Guest Sign In",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                  color: Colors.white,
                  // shape: const RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(2))),
                  padding: const EdgeInsets.all(10),
                )),

            SizedBox(
              height: MediaQuery.of(context).size.width * 0.25,
            ),
            Container(
                width: 350,
                alignment: AlignmentDirectional.center,
                child: Text("Term and conditions",
                    style:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
            // Container(
            //     margin: const EdgeInsets.only(top: 30),
            //     width: MediaQuery.of(context).size.width * 0.35,
            //     child: MaterialButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => const StarbucksApp()),
            //         );
            //       },
            //       child: const Text('Guest',
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.w700,
            //               fontSize: 16)),
            //       color: Color.fromARGB(255, 32, 9, 3),
            //       shape: const RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(10))),
            //       padding: const EdgeInsets.all(16),
            //     ))

            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            // Card(
            //   elevation: 70,
            //   color: Colors.white54,
            //   child: Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: Column(
            //       children: <Widget>[
            //         const SizedBox(
            //           height: 20,
            //         ),
            //         Container(
            //           padding: EdgeInsets.all(10),
            //           child: Image.asset(
            //             'assets/images/bfs.png',
            //             // height: 50,
            //             // width: 100,
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 20,
            //         ),
            //                 const SizedBox(
            //                   height: 10,
            //                 ),
            //
            //
            //         const SizedBox(
            //           height: 20,
            //         ),
            //         Container(
            //           margin: const EdgeInsets.only(bottom: 10),
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               InkWell(
            //                 onTap: () {
            //
            //                 },
            //                 child: const Text(
            //                   'Forgot Password',
            //                   style: TextStyle(
            //                       fontSize: 15,
            //                       color: Colors.black87,
            //                       fontFamily: "Avenir",
            //                       fontWeight: FontWeight.w500,
            //                       fontStyle: FontStyle.normal),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            //   ],
            // ),
          ],
        ));
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  void loginValidation(BuildContext context) async {
    bool isLoginValid = true;
    FocusScope.of(context).requestFocus(FocusNode());

    if (emailController.text.isEmpty) {
      isLoginValid = false;
      _onWidgetDidBuild(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username Tidak Boleh Kosong'),
            backgroundColor: Colors.red,
          ),
        );
        passwordController.clear();
        emailController.clear();
      });
    }

    if (passwordController.text.isEmpty) {
      isLoginValid = false;
      _onWidgetDidBuild(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password Tidak Boleh Kosong'),
            backgroundColor: Colors.red,
          ),
        );
        passwordController.clear();
        emailController.clear();
      });
    }
    if (isLoginValid) {
      fetchLogin(context, emailController.text, passwordController.text);
      passwordController.clear();
      emailController.clear();
    }
  }

  fetchLogin(BuildContext context, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    showLoaderDialog(context);
    try {
      Response response;
      var dio = Dio();

      FormData formData = new FormData.fromMap({
        "username": email,
        "password": password,
      });

      response = await dio.post(
        ip + "checklogin.php", //endpoint api Login
        data: formData,
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200) {
        //berhasil
        hideLoaderDialog(dialogContext);
        print("dismiss dialog");
        //setSharedPreference
        //String prefEmail = email;
        //String prefToken = response.data['token'];
        //await prefs.setString('email', prefEmail);
        //await prefs.setString('token', prefToken);
        //Messsage

        var hasil = jsonDecode(response.data);
        if (hasil["found"] == "ok") {
          //print("user " + hasil["user"].toString());
          dynamic user = jsonEncode(hasil["user"]);

          if (hasil["user"]["isValid"].toString() == "0") {
            await prefs.setString('user', jsonEncode(hasil["user"]));
            _onWidgetDidBuild(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login Berhasil'),
                  backgroundColor: Colors.green,
                ),
              );
            });
            bunyi();
            //homePage
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const userpassword()));
          } else {
            await prefs.setString('user', jsonEncode(hasil["user"]));
            print("hasil dari invalid :");
            print(hasil["user"]["isValid"].toString());
            _onWidgetDidBuild(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login Berhasil'),
                  backgroundColor: Colors.green,
                ),
              );
            });
            bunyi();
            //homePage
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const StarbucksApp()));
          }
        } else {
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login Gagal'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
      }
    } on DioError catch (e) {
      hideLoaderDialog(context);

      if (e.response?.statusCode == 400) {
        //gagal
        String errorMessage = e.response?.data['error'];
        _onWidgetDidBuild(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        });
      } else {
        // print(e.message);
      }
    }
  }

  BuildContext? dialogContext;
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Sign in...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return alert;
      },
    );
  }

  hideLoaderDialog(BuildContext? context) {
    if (context != null) {
      return Navigator.pop(context);
    }
  }
}

showDialogFunc(context) {
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
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.fmd_good_rounded),
                    Text(
                      "Please contact our nearby Outlets...",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
          ),
        );
      });
}
