import 'package:flutter/material.dart';
import 'package:mvvm_flutter/common/color.dart';
import 'package:mvvm_flutter/ui/bloc/LoginUser/LoginUserBloc.dart';
import 'package:mvvm_flutter/ui/page/singleUserActivity/single.dart';
import 'package:mvvm_flutter/utils/appRoute.dart';
import 'package:rive/rive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/color.dart';
import '../../../../main.dart';
import '../../../../utils/RiveUtils.dart';
import '../../../../utils/componentUi/customPositionAnimated.dart';

class LoginForm extends StatefulWidget {
  final LoginUserBloc loginViewModel;
  const LoginForm({super.key, required this.loginViewModel});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowCongrats = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger congrast;
  bool _submitted = false;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginUserBloc, LoginUserState>(
      listener: _onLoginBlocListener,
      builder: (context, state) {
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: TextFormField(
                      controller: emailController,
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
                      controller: passwordController,
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
                            const Text(
                              "Ingat saya",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const Text(
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
                        minimumSize: const Size(double.infinity, 56),
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
                          congrast = controller.findSMI("Trigger explosion")
                              as SMITrigger;
                        },
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        );
      },
    );
  }

  void logIn(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowCongrats = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (_formkey.currentState!.validate()) {
        _onLoginClick();
      } else {
        error.fire();
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isShowLoading = false;
          });
        });
      }
    });
  }

  void _onLoginClick() {
    setState(() {
      isShowLoading = true;
      isShowCongrats = true;
      _submitted = true;
    });
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      BlocProvider.of<LoginUserBloc>(context).add(LoginEventClick());
    } else {
      error.fire();
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isShowLoading = false;
        });
      });
    }
  }

  void setIsLoginPref(String token) async {
    final sharedpref = await SharedPreferences.getInstance();
    sharedpref.setBool('isLogin', true);
    sharedpref.setString('isToken', token);
  }

  Future<void> _onLoginBlocListener(
      BuildContext context, LoginUserState state) async {
    if (state is LoginStateClicked) {
      debugPrint('LoginStateLoginClicked');
      BlocProvider.of<LoginUserBloc>(context).add(PostLoginUserEvent(
          passwordController.text,
          email: emailController.text));
    } else if (state is LoginUserSucces) {
      setIsLoginPref(state.user.token!);
      check.fire();
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isShowLoading = false;
        });

        congrast.fire();

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => AppRoute.singleUserActivity()),
              (route) => false);
        });
      });
    } else if (state is LoginUserError) {
      error.fire();
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isShowLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: colorPrimary,
              duration: const Duration(seconds: 5),
              //behavior mengatur jenis snackbar
              behavior: SnackBarBehavior.fixed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.info_outline),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 280,
                    child: const Text(
                      "Login Gagal, Pastikan email dan kata sandi yang diisi benar dan terdaftar",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
      debugPrint(
          'LoginStateError, ${state.message} email : ${emailController.text} pass : ${passwordController.text}');
    }
  }
}
