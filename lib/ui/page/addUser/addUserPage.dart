import 'package:flutter/material.dart';
import 'package:mvvm_flutter/ui/bloc/CreateUser/CreateUserBloc.dart';
import 'package:mvvm_flutter/utils/appRoute.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import '../../../common/color.dart';
import '../../../utils/RiveUtils.dart';
import '../../../utils/componentUi/customPositionAnimated.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _addUserPageState();
}

class _addUserPageState extends State<AddUserPage> {
  Color _nameColor = Colors.grey[200]!;
  Color _jobColor = Colors.grey[200]!;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowCongrats = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger congrast;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    jobController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    jobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // fix bug bottom overflowed
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        title: const Text("Add User"),
      ),
      body: BlocConsumer<CreateUserBloc, CreateUserState>(
        listener: _onCreateBlocListener,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: colorPrimaryDark),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: _nameColor,
                    ),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                      onTap: () {
                        setState(() {
                          _nameColor = colorPrimaryLight;
                          _jobColor = Colors.grey[200]!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Job",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: colorPrimaryDark),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: _jobColor,
                    ),
                    child: TextField(
                      controller: jobController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Job',
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                      onTap: () {
                        setState(() {
                          _nameColor = Colors.grey[200]!;
                          _jobColor = colorPrimaryLight;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        logIn(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => AppRoute.singleUserActivity(),
                        //     ));
                      },
                      icon: const Icon(Icons.person_pin_sharp),
                      label: const Text(
                        "Add User",
                        style: TextStyle(fontSize: 14),
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
                  Container(
                    height: 120,
                    child: Stack(
                      children: [
                        isShowLoading
                            ? CustomPositioned(
                                child: RiveAnimation.asset(
                                  "assets/RiveAssets/check.riv",
                                  onInit: (artBoard) {
                                    StateMachineController controller =
                                        RiveUtils.getRiveController(artBoard);
                                    check = controller.findSMI("Check")
                                        as SMITrigger;
                                    error = controller.findSMI("Error")
                                        as SMITrigger;
                                    reset = controller.findSMI("Reset")
                                        as SMITrigger;
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
                                      congrast = controller.findSMI(
                                          "Trigger explosion") as SMITrigger;
                                    },
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void logIn(BuildContext context) {
    print("masuk logIn");
    setState(() {
      isShowLoading = true;
      isShowCongrats = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (_formkey.currentState!.validate() &&
          nameController.text.isNotEmpty &&
          jobController.text.isNotEmpty) {
        _onClick();
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

  void _onClick() {
    print("masuk onClick");
    setState(() {
      isShowLoading = true;
      isShowCongrats = true;
      _submitted = true;
    });
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      BlocProvider.of<CreateUserBloc>(context).add(CreateEventClick());
    } else {
      error.fire();
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isShowLoading = false;
        });
      });
    }
  }

  Future<void> _onCreateBlocListener(
      BuildContext context, CreateUserState state) async {
    if (state is CreateStateClicked) {
      debugPrint('LoginStateLoginClicked');
      BlocProvider.of<CreateUserBloc>(context)
          .add(PostCreateUserEvent(nameController.text, jobController.text));
    } else if (state is CreateUserSucces) {
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
    } else if (state is CreateUserError) {
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
                      "Gagal Membuat User Harap Coba Lagi",
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
          'LoginStateError, ${state.message} email : ${nameController.text} pass : ${jobController.text}');
    }
  }
}
