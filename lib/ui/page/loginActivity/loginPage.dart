import 'package:flutter/material.dart';
import 'package:mvvm_flutter/common/color.dart';
import 'package:mvvm_flutter/main.dart';
import 'package:mvvm_flutter/ui/page/singleUserActivity/single.dart';

import 'component/LoginForm.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    colorbgPrimary,
                    colorPrimaryLight,
                    colorbgPrimaryDark
                  ])),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Center(
                child: Image.asset(
                  "assets/image/iconhome.png",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const MyApp();
                  }),
                );
              },
              child: const SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.arrow_back,
                  size: 40,
                  weight: 40,
                  color: Colors.white,
                ),
              )),
            ),
            SizedBox.expand(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                    color: Colors.white),
                margin: EdgeInsets.only(top: 140),
                // color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Hallo, Selamat Datang \nKembali..",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const LoginForm(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 1,
                            width: 80,
                            color: Colors.grey,
                          ),
                          Text(
                            "atau masuk dengan",
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                          Container(
                            height: 1,
                            width: 75,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/image/googleimage.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: RichText(
                          text: const TextSpan(
                              text: "Belum memiliki akun? ",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              children: [
                            TextSpan(
                              text: 'Daftar disini',
                              style: TextStyle(
                                color: colorPrimary,
                                fontSize: 12,
                              ),
                            )
                          ])),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
