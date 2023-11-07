import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("home screen"),
      ],
    ));
  }
}
