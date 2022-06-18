int getSecFromTime(double sec) {
  return sec.toInt() % 60;
}

int getMinFromTime(double sec) {
  return sec ~/ 60 % 60;
}

int getHourFromTime(double sec) {
  return sec ~/ 3600;
}

double getLimSecFromTime(double sec) {
  return sec % 60;
}

double getFullMinFromTime(double sec) {
  return sec / 60;
}

double getFullHourFromTime(double sec) {
  return sec / 3600;
}
