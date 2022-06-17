class TimeSpan {
  int _day = 0;
  int _hour = 0;
  int _minute = 0;
  double _second = 0;
  int _milliSec = 0;
  int _fullMilliSec = 0;

  TimeSpan({int day = 0, int hour = 0, int minute = 0, double second = 0}) {
    _day = day;
    _hour = hour;
    _minute = minute;
    _second = second;
    _milliSec = (_second * 1000).toInt();
    //カプセル化しつつコンストラクタ外で使うための処理です、効率が悪いかもしれません
    //secondは他で使うときintにキャストする関係上少数第四位以下の情報はsecondにしか保存されません

    _fullMilliSec =
        _day * 86400000 + _hour * 3600000 + _minute * 60000 + _milliSec;
  }

  void fromMilliSec(int fromMS) {
    _fullMilliSec += fromMS;
  }

  int get day => _fullMilliSec ~/ 86400000;
  int get hour => _fullMilliSec ~/ 3600000 % 24;
  int get minute => _fullMilliSec ~/ 60000 % 60;
  int get second => _fullMilliSec ~/ 1000 % 60;
  int get milliSec => _fullMilliSec % 1000;
}
