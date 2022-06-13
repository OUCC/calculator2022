class Fruction {
  int Numerator, Denominator;
  Fruction(this.Numerator, this.Denominator) {
    if (Denominator == 0) {
      throw ArgumentError("分母が0になっています");
    } else if (Denominator < 0) {
      Denominator *= -1;
      Numerator *= -1;
    }
    Reduce();
  }

  ///約分する
  void Reduce() {
    int gcd = Gcd(Numerator, Denominator);
    Numerator = (Numerator / gcd).toInt();
    Denominator = (Denominator / gcd).toInt();
  }

  @override
  String toString() {
    return "$Numerator/$Denominator";
  }

  ///最大公約数を求める
  int Gcd(int a, int b) {
    return ((a % b) == 0) ? b : Gcd(b, (a % b));
  }

  @override
  int get hashCode {
    var result = 3;
    result = 31 * result + Numerator.hashCode;
    result = 31 * result + Denominator.hashCode;
    return result;
    //return Object.hash(Numerator, Denominator);
  }

  //以下演算子のオーバーロード
  Fruction operator +(dynamic a) {
    if (a.runtimeType == Fruction) {
      Fruction i = a;
      return Fruction(Numerator * i.Denominator + i.Numerator * Denominator,
          Denominator * i.Denominator);
    } else if (a.runtimeType == int) {
      int i = a;
      return Fruction(Numerator + i * Denominator, Denominator);
    } else {
      throw ArgumentError("無効な計算です");
    }
  }

  Fruction operator -(dynamic a) {
    if (a.runtimeType == Fruction) {
      Fruction i = a;
      return Fruction(Numerator * i.Denominator - i.Numerator * Denominator,
          Denominator * i.Denominator);
    } else if (a.runtimeType == int) {
      int i = a;
      return Fruction(Numerator - i * Denominator, Denominator);
    } else {
      throw ArgumentError("無効な計算です");
    }
  }

  Fruction operator *(dynamic a) {
    if (a.runtimeType == Fruction) {
      Fruction i = a;
      return Fruction(i.Numerator * Numerator, i.Denominator * Numerator);
    } else if (a.runtimeType == int) {
      int i = a;
      return Fruction(Numerator * i, Denominator);
    } else {
      throw ArgumentError("無効な計算です");
    }
  }

  Fruction operator /(dynamic a) {
    if (a.runtimeType == Fruction) {
      Fruction i = a;
      return Fruction(
          this.Numerator * i.Denominator, this.Denominator * i.Numerator);
    } else if (a.runtimeType == int) {
      int i = a;
      return Fruction(Numerator, Denominator * i);
    } else {
      throw ArgumentError("無効な計算です");
    }
  }

  @override
  bool operator ==(dynamic a) {
    return a is Fruction &&
        a.Denominator == Denominator &&
        a.Numerator == Numerator;
  }
}
