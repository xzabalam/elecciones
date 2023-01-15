import 'package:flutter/material.dart';

class EscribirTextoWidget extends StatelessWidget {
  String texto;

  EscribirTextoWidget({Key? key, required this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 216,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            textAlign: TextAlign.center,
            texto!,
            softWrap: true,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          )),
    );
  }


}
