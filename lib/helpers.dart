String formatTime(int seconds, bool pad) {
  // 70/60 => 1 (minute)
  // 70%60 => 10 (seconds)
  return (pad)
      ? "${(seconds / 60).floor()}:${(seconds % 60).toString().padLeft(2, "0")}"
      : (seconds > 59)
          ? "${(seconds / 60).floor()}:${(seconds % 60).toString().padLeft(2, "0")}"
          : seconds.toString();
}
