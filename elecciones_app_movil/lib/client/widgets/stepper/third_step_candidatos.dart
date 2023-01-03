import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThirdStepCandidatoWidget extends ConsumerWidget {
  const ThirdStepCandidatoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Mobile Number'),
    );
  }
}
