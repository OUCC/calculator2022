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

