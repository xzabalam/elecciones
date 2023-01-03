import 'package:elecciones_app_movil/businness/providers/ubicacion/ubicacion_provider.dart';
import 'package:elecciones_app_movil/client/widgets/stepper/index_steps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistroVotosWidget extends ConsumerStatefulWidget {
  const RegistroVotosWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _RegistroVotosWidgetState();
}

class _RegistroVotosWidgetState extends ConsumerState<RegistroVotosWidget> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final ubicacionNotifier = ref.watch(ubicacionProvider);

    return Stepper(
      type: StepperType.horizontal,
      physics: const ScrollPhysics(),
      currentStep: _currentStep,
      onStepTapped: (step) => tapped(step),
      controlsBuilder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (ubicacionNotifier.juntaSeleccionada != null) {
                  continued();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text(
                          "Primero debe seleccionar una ubicación completa.")));
                }
              },
              child: const Text('Siguiente'),
            ),
            TextButton(
              onPressed: cancel,
              child: const Text('Anterior'),
            ),
          ],
        );
      },
      steps: [
        Step(
          title: const Text('Ubicación', style: TextStyle(fontSize: 13)),
          content: const FirstStepUbicacionWidget(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: const Text('Dignidades', style: TextStyle(fontSize: 13)),
          content: const SecondStepDignidadesWidget(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: const Text('Candidatos', style: TextStyle(fontSize: 13)),
          content: const ThirdStepCandidatoWidget(),
          isActive: _currentStep >= 0,
          state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
        )
      ],
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
