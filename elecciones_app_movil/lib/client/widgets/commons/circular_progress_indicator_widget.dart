import 'package:flutter/material.dart';

class CircularProgessIndicatorCustomWidget extends StatelessWidget {
  const CircularProgessIndicatorCustomWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
              width: 20, height: 20, child: CircularProgressIndicator())),
    );
  }
}
