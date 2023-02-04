import 'package:elecciones_app_movil/domain/notifiers/candidatos/acta_dignidad_notifier.dart';
import 'package:elecciones_app_movil/domain/notifiers/ubicacion/ubicacion_notifier.dart';
import 'package:elecciones_app_movil/ui/screens/registro_votos/widgets/stepper/index_steps.dart';
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
    final actaDignidadNotifier = ref.watch(actaDignidadProvider);

    return Stepper(
      type: StepperType.horizontal,
      physics: const ScrollPhysics(),
      elevation: 2,
      currentStep: _currentStep,
      onStepTapped: (step) => tapped(step),
      controlsBuilder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (_currentStep >= 1)
              ElevatedButton.icon(
                onPressed: cancel,
                icon: Icon(Icons.arrow_back_outlined),
                label: const Text('Anterior'),
              ),
            if (_currentStep <= 1)
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Si en la primera pestaña no se ha seleccionado la ubicación, se debe mostrar un mensaje de error.
                      if (_currentStep == 0 && ubicacionNotifier.juntaSeleccionada == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Primero debe seleccionar una ubicación completa.")));
                        return;
                      }

                      // Si en la segunda pestaña no se ha seleccionado una dignidad, se debe mostrar un mensaje de error.
                      if (_currentStep == 1 && actaDignidadNotifier.posicionDignidadSeleccionada == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text("Primero debe seleccionar una dignidad.")));
                        return;
                      }

                      continued();
                    },
                    icon: Icon(Icons.arrow_back_outlined),
                    label: const Text('Siguiente'),
                  )),
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
