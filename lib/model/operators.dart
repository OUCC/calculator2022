import 'dart:math';

/// 演算子
typedef Operator = int;

/// 二項演算子
typedef BinaryOperator = double Function(double left, double right);

/// 単項演算子
typedef UnaryOperator = double Function(double arg);

final Map<String, Operator> _strOprMap = {
  "(": 0x001,
  ")": 0x002,
  "+": 0x100,
  "-": 0x101,
  "*": 0x110,
  "/": 0x111,
  "^": 0x120,
  "sin": 0x2F0,
  "cos": 0x2F1,
  "tan": 0x2F2,
  "ln": 0x2F3,
  "log": 0x2F4,
  "sqrt": 0x2F5
};

final Map<Operator, BinaryOperator> _binaryOprFuncMap = {
  0x100: (left, right) => left + right,
  0x101: (left, right) => left - right,
  0x110: (left, right) => left * right,
  0x111: (left, right) => left / right,
  0x120: (left, right) => pow(left, right).toDouble()
};

final Map<Operator, UnaryOperator> _unaryOprFuncMap = {
  0x2F0: (arg) => sin(arg), // 弧度法
  0x2F1: (arg) => cos(arg),
  0x2F2: (arg) => tan(arg),
  0x2F3: (arg) => log(arg),
  0x2F4: (arg) => log(arg) / ln10,
  0x2F5: (arg) => sqrt(arg),
};

extension OperatorEx on Operator {
  /// 二項演算子であるときtrueを返します
  bool get isBinary => this & 0x100 != 0;

  /// 単項演算子であるときtrueを返します
  bool get isUnary => this & 0x200 != 0;

  /// 有効な演算子であるときtrueを返します
  bool get isValid =>
      _binaryOprFuncMap[this] != null || _unaryOprFuncMap[this] != null;

  /// 優先度を取得します
  Operator get priority => this & 0x0F0;

  /// 二項演算子を実行する関数を返します
  ///
  /// 二項演算子でない者に対して実行された場合[ArgumentError]が投げられます
  BinaryOperator get binaryOperator {
    if (!isBinary) {
      throw ArgumentError.value(this, "$thisは二項演算子ではありません。");
    }
    var func = _binaryOprFuncMap[this];
    if (func == null) {
      throw UnimplementedError("$thisの演算はまだ実装されていません。");
    }
    return func;
  }

  /// 単項項演算子を実行する関数を返します
  ///
  /// 単項演算子でない者に対して実行された場合[ArgumentError]が投げられます
  UnaryOperator get unaryOperator {
    if (!isUnary) {
      throw ArgumentError.value(this, "$thisは単項演算子ではありません。");
    }
    var func = _unaryOprFuncMap[this];
    if (func == null) {
      throw UnimplementedError("$thisの演算はまだ実装されていません。");
    }
    return func;
  }

  /// 演算子を辞書に登録されているキーに変換します。
  String toOperatorString() {
    return _strOprMap.entries
        .where((entry) => entry.value == this)
        .map((entry) => entry.key)
        .first;
  }
}

/// 文字列を演算子に変換します
///
/// 引数が正しい演算子の形式の文字列でない場合は[ArgumentError]が投げられます
Operator parseStr2Opr(String operatorStr) {
  var opr = _strOprMap[operatorStr];
  if (opr == null) {
    throw ArgumentError.value(operatorStr, "引数operatorStrが正しい形式ではありません。",
        "operatorStrは${_strOprMap.keys.join(", ")}のいずれかである必要があります。");
  }
  return opr;
}

/// 二項演算子を新しく登録します
Operator registerBinaryOperator(
    String opratorStr, Operator operator, BinaryOperator binaryOperator) {
  if (!operator.isBinary) {
    throw ArgumentError.value(operator, "引数operatorが正しい形式ではありません。",
        "operatorは operator&0x100 != 0 を満たす必要があります。");
  }
  _strOprMap[opratorStr] = operator;
  _binaryOprFuncMap[operator] = binaryOperator;
  return operator;
}

/// 単項演算子を新しく登録します
Operator registerUnaryOperator(
    String opratorStr, Operator operator, UnaryOperator unaryOperator) {
  if (!operator.isUnary) {
    throw ArgumentError.value(operator, "引数operatorが正しい形式ではありません。",
        "operatorは operator&0x200 != 0 を満たす必要があります。");
  }
  _strOprMap[opratorStr] = operator;
  _unaryOprFuncMap[operator] = unaryOperator;
  return operator;
}

class Operators {
  /// `(` 左の括弧
  static const Operator leftBrace = 0x001;

  /// `)` 右の括弧
  static const Operator rightBrace = 0x002;

  /// `+` 足し算
  static const add = 0x100;

  /// `-` 引き算
  static const sub = 0x101;

  /// `*` 掛け算
  static const multi = 0x110;

  /// `/` 割り算
  static const div = 0x111;

  /// `^` 累乗
  static const pow = 0x120;

  /// `sin` sin関数 引数は弧度法
  static const sin = 0x2F0;

  /// `cos` cos関数 引数は弧度法
  static const cos = 0x2F1;

  /// `tan` tan関数 引数は弧度法
  static const tan = 0x2F2;

  /// `ln` 自然対数 eが底の対数関数
  static const ln = 0x2F3;

  /// `log` 常用対数 10が底の対数関数
  static const log = 0x2F4;

  /// `sqrt` 平方根
  static const sqrt = 0x2F5;
}
