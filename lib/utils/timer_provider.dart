import 'package:flutter/material.dart';
import 'dart:async'; // For Timer functionality
import 'dart:math'; // For random number generation

class TimerProvider {
  final ValueNotifier<int> timeNotifier = ValueNotifier<int>(0);
  Timer? _timer;
  int _elapsedTime = 0;

  // Start or resume the timer
  void startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _elapsedTime++;
        timeNotifier.value = _elapsedTime;
      });
    }
  }

  // Pause the timer
  void pauseTimer() {
    _timer?.cancel();
  }

  // Reset the timer
  void resetTimer() {
    _elapsedTime = 0;
    timeNotifier.value = _elapsedTime;
  }

  // Dispose of the timer
  void dispose() {
    _timer?.cancel();
  }
}
