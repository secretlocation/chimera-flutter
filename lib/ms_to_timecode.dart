String convertMsToTimecode(int ms)
{
  String result;

  Duration dur = Duration(milliseconds: ms);
  result = dur.inMinutes.toString();
  result += ":" + (dur.inSeconds.remainder(60)).toString().padLeft(2, '0');

  return result;
}
