class Utils {
  static String formatDuration(
      {required int secondsDuration, bool withHours = false}) {
    final duration = Duration(seconds: secondsDuration);

    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "${withHours ? '$hours:' : ''}$minutes:$seconds";
  }
}
