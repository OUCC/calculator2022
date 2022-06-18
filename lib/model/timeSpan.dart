import 'dart:math' as Math;

int getSecFromTime(double sec) {
  return sec.toInt() % 60;
}

int getMinFromTime(double sec) {
  return sec ~/ 60 % 60;
}

int getHourFromTime(double sec) {
  return sec ~/ 3600;
}

double castNum(double num) {
  const int cast = 1000000;
  return (num * cast).toInt() / cast;
  //(cast ^ -1)未満をキャストするための関数です(現在はマイクロ)
}

double getLimSecFromTime(double sec) {
  return castNum(sec % 60);
}

double getFullMinFromTime(double sec) {
  return castNum(sec / 60);
}

double getFullHourFromTime(double sec) {
  return castNum(sec / 3600);
}

String getStrFromTime(double sec) {
  final int hour = getHourFromTime(sec);
  final int min = getMinFromTime(sec);
  final double limSec = getLimSecFromTime(sec);

  return hour.toString() + ":" + min.toString() + ":" + limSec.toString();
}

double getTimeFromStr(String strTime) {
  List strTimes = strTime.split(':');
  List dblTimes = <double>[];
  double totSec = 0;
  final int k = strTimes.length;
  for (int i = 0; i < k; i++) {
    if (strTimes[i] == "") {
      strTimes[i] = "0";
    }
    dblTimes.add(double.parse(strTimes[i]));
  }
  for (int j = 0; j < k; j++) {
    int l = k - j - 1;
    totSec += dblTimes[l] * Math.pow(60, j);
  }

  return totSec;
}
