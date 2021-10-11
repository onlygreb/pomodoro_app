import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro_app/components/timer.dart';
import 'package:pomodoro_app/components/time_input.dart';
import 'package:pomodoro_app/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: PomodoroTimer(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TimeInput(
                    titulo: 'Work',
                    valor: store.workTime,
                    inc: store.started && store.isWorking()
                        ? null
                        : store.incrementWorkTime,
                    dec: store.started && store.isWorking()
                        ? null
                        : store.decrementWorkTime,
                  ),
                  TimeInput(
                    titulo: 'Rest',
                    valor: store.restTime,
                    inc: store.started && store.isResting()
                        ? null
                        : store.incrementRestTime,
                    dec: store.started && store.isResting()
                        ? null
                        : store.decrementRestTime,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}