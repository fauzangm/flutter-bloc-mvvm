import 'package:flutter/material.dart';

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
