import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum BreakType { WORK, REST }

abstract class _PomodoroStore with Store {
  @observable
  bool started = false;

  @observable
  int minutes = 2;

  @observable
  int seconds = 0;

  @observable
  int workTime = 2;

  @observable
  int restTime = 1;

  @observable
  BreakType breakType = BreakType.WORK;

  Timer? timer;

  @action
  void start() {
    started = true;
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (minutes == 0 && seconds == 0) {
        _changeBreakType();
      } else if (seconds == 0) {
        seconds = 59;
        minutes--;
      } else {
        seconds--;
      }
    });
  }

  @action
  void stop() {
    started = false;
    timer?.cancel();
  }

  @action
  void restart() {
    stop();
    minutes = isWorking() ? workTime : restTime;
    seconds = 0;
  }

  @action
  void incrementWorkTime() {
    workTime++;
    if (isWorking()) {
      restart();
    }
  }

  @action
  void decrementWorkTime() {
    if (workTime > 1) {
      workTime--;
      if (isWorking()) {
        restart();
      }
    }
  }

  @action
  void incrementRestTime() {
    restTime++;
    if (isResting()) {
      restart();
    }
  }

  @action
  void decrementRestTime() {
    if (restTime > 1) {
      restTime--;
      if (isResting()) {
        restart();
      }
    }
  }

  bool isWorking() {
    return breakType == BreakType.WORK;
  }

  bool isResting() {
    return breakType == BreakType.REST;
  }

  void _changeBreakType() {
    if (isWorking()) {
      breakType = BreakType.REST;
      minutes = restTime;
    } else {
      breakType = BreakType.WORK;
      minutes = workTime;
    }
    seconds = 0;
  }
}