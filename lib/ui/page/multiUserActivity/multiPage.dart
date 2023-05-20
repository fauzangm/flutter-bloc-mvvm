import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/MultiUser/MultiUserBloc.dart';
import 'package:mvvm_flutter/common/color.dart';
import 'package:mvvm_flutter/data/remote/response/MultiUser.dart';
import 'package:mvvm_flutter/utils/componentUi/card_view.dart';

class MultiPage extends StatefulWidget {
  const MultiPage({super.key});

  @override
  State<MultiPage> createState() => _MultiPageState();
}

class _MultiPageState extends State<MultiPage> {
  final Random random = Random();
  @override
  void initState() {
    Future.microtask(() => context
        .read<MultiUserBloc>()
        .add(GetMultiUserEvent(idpage: random.nextInt(3))));
    super.initState();
  }

  Widget build(BuildContext context) {
    MultiUserBloc multiUserViewModel = BlocProvider.of<MultiUserBloc>(context);

    void _onGetMultiUserEvent(MultiUser multiUser) {
      BlocProvider.of<MultiUserBloc>(context)
          .add(GetMultiUserEvent(idpage: random.nextInt(3)));
    }

    return Scaffold(
        appBar: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            backgroundColor: colorPrimary,
            title: const Text("Multi User")),
        body: BlocBuilder<MultiUserBloc, MultiUserState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      multiUserViewModel
                          .add(GetMultiUserEvent(idpage: random.nextInt(3)));
                    },
                    child: Text("Pick Random Multi User"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                GetMultiUser(
                  multiUser: _onGetMultiUserEvent,
                )
              ],
            );
          },
        ));
  }
}

// class ListMultiUserPage extends StatelessWidget {
//   const ListMultiUserPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Random random = Random();
//     MultiUserBloc multiUserViewModel = BlocProvider.of<MultiUserBloc>(context);

//   }
// }

class GetMultiUser extends StatelessWidget {
  final Function(MultiUser) multiUser;
  const GetMultiUser({
    super.key,
    required this.multiUser,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MultiUserBloc, MultiUserState>(
      listener: (context, state) {
        if (state is MultiUserError) {
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
                      "Gagal Menghubungi Server, Harap Periksa Koneksi Internet Kamu",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  //   },
                  //   child: const Icon(Icons.close),
                  // ),
                ],
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is MultiUserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MultiUserSucces) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.user.data?.length,
              itemBuilder: (context, index) {
                return UserCard(state.user.data![index]);
                //   ElevatedButton(
                //       onPressed: () {},
                //       child:
                //           Text("${state.user.data![index].firstName}"));
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
