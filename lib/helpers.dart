String getTimerString(int duration) {
  final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
  final secondsStr = (duration % 60).toString().padLeft(2, '0');
  final timerString = '$minutesStr:$secondsStr';
  return timerString;
}
