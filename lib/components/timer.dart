import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro_app/components/timer_button.dart';
import 'package:pomodoro_app/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class PomodoroTimer extends StatelessWidget {
  const PomodoroTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Observer(
      builder: (_) {
        return Container(
          color: store.isWorking() ? Colors.red : Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                store.isWorking()
                    ? "It's Time to Work"
                    : "It's Time to Rest",
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${store.minutes.toString().padLeft(2, '0')}:${store.seconds.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: 120,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!store.started)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TimerButton(
                        texto: 'Start',
                        icone: Icons.play_arrow,
                        click: store.start,
                      ),
                    ),
                  if (store.started)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TimerButton(
                        texto: 'Stop',
                        icone: Icons.stop,
                        click: store.stop,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TimerButton(
                      texto: 'Restart',
                      icone: Icons.refresh,
                      click: store.restart,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
