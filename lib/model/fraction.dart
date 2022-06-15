class Fraction {
  int numerator, denominator;
  Fraction(this.numerator, this.denominator) {
    if (denominator == 0) {
      throw ArgumentError("分母が0になっています");
    } else if (denominator < 0) {
      denominator *= -1;
      numerator *= -1;
    }
    reduce();
  }

  ///約分する
  void reduce() {
    int _gcd = gcd(numerator, denominator);
    numerator = numerator ~/ _gcd;
    denominator = denominator ~/ _gcd;
  }

  @override
  String toString() {
    return "$numerator/$denominator";
  }

  ///最大公約数を求める
  int gcd(int a, int b) {
    return ((a % b) == 0) ? b : gcd(b, (a % b));
  }

  @override
  int get hashCode {
    var result = 3;
    result = 31 * result + numerator.hashCode;
    result = 31 * result + denominator.hashCode;
    return result;
    //return Object.hash(Numerator, Denominator);
  }

  //以下演算子のオーバーロード
  Fraction operator +(other) {
    if (other.runtimeType == Fraction) {
      Fraction i = other;
      return Fraction(numerator * i.denominator + i.numerator * denominator,
          denominator * i.denominator);
    } else if (other.runtimeType == int) {
      int i = other;
      return Fraction(numerator + i * denominator, denominator);
    } else {
      throw ArgumentError("無効な計算です");
    }
  }

  Fraction operator -(other) {
    if (other.runtimeType == Fraction) {
      Fraction i = other;
      return Fraction(numerator * i.denominator - i.numerator * denominator,
          denominator * i.denominator);
    } else if (other.runtimeType == int) {
      int i = other;
      return Fraction(numerator - i * denominator, denominator);
    } else {
      throw ArgumentError("無効な計算です");
    }
  }

  Fraction operator *(other) {
    if (other.runtimeType == Fraction) {
      Fraction i = other;
      return Fraction(i.numerator * numerator, i.denominator * numerator);
    } else if (other.runtimeType == int) {
      int i = other;
      return Fraction(numerator * i, denominator);
    } else {
      throw ArgumentError("無効な計算です");
    }
  }

  Fraction operator /(other) {
    if (other.runtimeType == Fraction) {
      Fraction i = other;
      return Fraction(numerator * i.denominator, denominator * i.numerator);
    } else if (other.runtimeType == int) {
      int i = other;
      return Fraction(numerator, denominator * i);
    } else {
      throw ArgumentError("無効な計算です");
    }
  }

  @override
  bool operator ==(other) {
    return other is Fraction &&
        other.denominator == denominator &&
        other.numerator == numerator;
  }
}
