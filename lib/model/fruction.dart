class Fruction {
  double Numerator, Denominator;
  Fruction(this.Numerator, this.Denominator) {
    final numrator=this.Numerator;
    Reduce();
  }
  void Reduce() {
    var gcd = Gcd(Numerator, Denominator);
    Numerator /= gcd;
    Denominator /= gcd;
  }

  @override
  String toString() {
    return Numerator.toString() + "/" + Denominator.toString();
  }

  num Gcd(num a, num b) {
    return ((a % b) == 0) ? b : Gcd(b, (a % b));
  }

  @override
  int get hashCode {
    var result = 3;
    result = 31 * result + Numerator.hashCode;
    result = 31 * result + Denominator.hashCode;
    return result;
  }
  
  Fruction operator +(Fruction i) {
    return Fruction(this.Numerator*i.Denominator+i.Numerator*this.Denominator, this.Denominator*i.Denominator);
  }

  Fruction operator -(Fruction i) {
    return Fruction(this.Numerator*i.Denominator - i.Numerator*this.Denominator, this.Denominator*i.Denominator);
  }

  Fruction operator *(Fruction i) {
    return Fruction(i.Numerator * this.Numerator, i.Denominator*this.Numerator);
  }

  Fruction operator /(Fruction i) {
    return Fruction(this.Numerator * this.Denominator, this.Denominator*i.Numerator);
  }

}
