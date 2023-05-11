import 'package:flutter/material.dart';
import 'package:mvvm_flutter/common/color.dart';
import 'package:mvvm_flutter/ui/singleUserActivity/single.dart';
import 'package:rive/rive.dart';

import '../../../common/color.dart';
import '../../../utils/RiveUtils.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowCongrats = false;
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger congrast;

  bool _rememberMe = false;
  void logIn(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowCongrats = true;
    });
    Future.delayed(Duration(seconds: 1), () {
      if (_formkey.currentState!.validate()) {
        check.fire();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });

          congrast.fire();

          Future.delayed(Duration(seconds: 1), () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SinglePage(),
                ));
          });
        });
      } else {
        error.fire();
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Surel",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  onSaved: (username) {},
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Kata Sandi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "";
                    }
                    return null;
                  },
                  onSaved: (username) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (newValue) {
                            setState(() {
                              _rememberMe = newValue!;
                            });
                          },
                          checkColor: Colors.white,
                          activeColor: colorPrimary,
                        ),
                        Text(
                          "Ingat saya",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      "Lupa Kata Sandi?",
                      style: TextStyle(color: colorPrimary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton.icon(
                  onPressed: () {
                    logIn(context);
                  },
                  icon: const Icon(Icons.arrow_right_alt_sharp),
                  label: const Text(
                    "Masuk",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimary,
                    minimumSize: Size(double.infinity, 56),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                  ),
                ),
              ),
            ],
          ),
        ),
        isShowLoading
            ? CustomPositioned(
                child: RiveAnimation.asset(
                  "assets/RiveAssets/check.riv",
                  onInit: (artBoard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artBoard);
                    check = controller.findSMI("Check") as SMITrigger;
                    error = controller.findSMI("Error") as SMITrigger;
                    reset = controller.findSMI("Reset") as SMITrigger;
                  },
                ),
              )
            : const SizedBox(),
        isShowCongrats
            ? CustomPositioned(
                //scale digunakan untuk mengatur size dari rive animation
                child: Transform.scale(
                  scale: 7,
                  child: RiveAnimation.asset(
                    "assets/RiveAssets/confetti.riv",
                    onInit: (artBoard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artBoard);
                      congrast =
                          controller.findSMI("Trigger explosion") as SMITrigger;
                    },
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, required this.child, this.size = 100});

  final Widget child;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Column(
      children: [
        const Spacer(
            // flex: 2,
            ),
        SizedBox(
          height: 100,
          width: 100,
          child: child,
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    ));
  }
}
