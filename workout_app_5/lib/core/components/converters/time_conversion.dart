
class TimeFormat {
  final String minutes;
  final String seconds;

  String displayedTime = '00:00';

  void makeDisplayedTime() {
    String tempSeconds;
    tempSeconds = seconds;
    if(int.parse(seconds) < 10) {
      tempSeconds = '0' + tempSeconds;
    }
    //displayedTime = '${int.parse(minutes)}:${int.parse(seconds)}';
    displayedTime = '$minutes:$tempSeconds';
  
  }

  TimeFormat({this.minutes,this.seconds});
}