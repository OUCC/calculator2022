typedef BinaryOperator = double Function(double left, double right);
typedef UnaryOperator = double Function(double arg);

/// 半角空白で区切られた式を逆ポーランド記法に基づく配列に変換します
List<Term> parseStrToPolish(String formula) {
  final terms = formula.split(' ');
  final stack = <String>[];
  final result = <Term>[];

  // https://knowledge.sakura.ad.jp/220/
  // これを参考にスタックを使って実装した
  for (var term in terms) {
    final num = double.tryParse(term);
    if (num != null) {
      // 数字はresultに積む
      result.add(Term.fromNum(num));
      continue;
    }

    if (term == "+" || term == "-") {
      // +, - より優先順位の高い演算子をstackからresultに積む
      while (stack.isNotEmpty) {
        final lastTerm = stack.last;
        if (lastTerm == "*" || lastTerm == "/") {
          result.add(
              Term.fromOpr(lastTerm == "*" ? operators.multi : operators.div));
          stack.removeLast();
          continue;
        } else {
          break;
        }
      }
      stack.add(term);
      continue;
    }

    if (term == ")") {
      // ) が出てきたら ( が出てくるまでstackからresultに積む
      while (stack.isNotEmpty) {
        final lastTerm = stack.last;
        if (lastTerm == "(") {
          stack.removeLast();
          break;
        }
        stack.removeLast();
        result.add(Term.fromOprStr(lastTerm));
      }
      continue;
    }

    stack.add(term);
  }

  // stackに残ってる演算子をstackに積む
  while (stack.isNotEmpty) {
    result.add(Term.fromOprStr(stack.removeLast()));
  }

  return result;
}

/// 逆ポーランド記法に基づく配列から演算を行います
double calculate(List<Term> terms) {
  final stack = <double>[];
  while (true) {
    final item = terms.removeAt(0);
    if (!item.isOperator) {
      stack.add(item.number);
    } else if (item.isOperator && item.operator.isBinary && stack.length >= 2) {
      final right = stack.removeLast();
      final left = stack.removeLast();
      stack.add(item.operator.binaryOperator(left, right));
    } else if (item.isOperator && !item.operator.isBinary && stack.isNotEmpty) {
      final arg = stack.removeLast();
      stack.add(item.operator.unaryOperator(arg));
    } else {
      throw ArgumentError.value(terms, "termsの形式が正しくありません。");
    }
    if (terms.isEmpty) {
      break;
    }
  }
  if (stack.length > 1) {
    throw ArgumentError.value(terms, "termsの形式が正しくありません。");
  }
  return stack.first;
}

/// 数式の数字又は演算子を表します
class Term {
  /// 演算子のときtrueを返します
  final bool isOperator;
  final double number;
  final operators operator;

  /// 数字から数字の[Term]を生成します
  Term.fromNum(this.number)
      : isOperator = false,
        operator = operators.add;

  /// 演算子から演算子の[Term]を生成します
  Term.fromOpr(this.operator)
      : isOperator = true,
        number = 0;

  /// 演算子の文字列から演算子の[Term]を生成します
  ///
  /// 正しい演算子の形式の文字列でない場合は[ArgumentError]が投げられます
  Term.fromOprStr(String oprStr) : this.fromOpr(parseStrToOpr(oprStr));

  /// 文字列を演算子に変換します
  ///
  /// 引数が正しい演算子の形式の文字列でない場合は[ArgumentError]が投げられます
  static operators parseStrToOpr(String oprStr) {
    operators opr;
    switch (oprStr) {
      case "*":
        opr = operators.multi;
        break;
      case "/":
        opr = operators.div;
        break;
      case "-":
        opr = operators.sub;
        break;
      case "+":
        opr = operators.add;
        break;
      default:
        throw ArgumentError.value(
            oprStr, "引数の形式エラー", "oprStrの形式が正しくありません。\noprStrは演算子である必要があります。");
    }
    return opr;
  }

  @override
  bool operator ==(covariant Term other) {
    return isOperator == other.isOperator &&
        number == other.number &&
        operator == other.operator;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}

extension OperatorExt on operators {
  /// 2項演算子であるときtrueを返します
  bool get isBinary {
    return this == operators.add ||
        this == operators.sub ||
        this == operators.multi ||
        this == operators.div;
  }

  /// 2項演算子を実行する関数を返します
  ///
  /// 2項演算子でない者に対して実行された場合[ArgumentError]が投げられます
  BinaryOperator get binaryOperator {
    switch (this) {
      case operators.add:
        return (left, right) => left + right;
      case operators.sub:
        return (left, right) => left - right;
      case operators.multi:
        return (left, right) => left * right;
      case operators.div:
        return (left, right) => left / right;
      default:
        if (!isBinary) {
          throw ArgumentError.value(this, "$thisは二項演算子ではありません。");
        } else {
          throw UnimplementedError("$thisの演算はまだ実装されていません。");
        }
    }
  }

  /// 単項項演算子を実行する関数を返します
  ///
  /// 単項演算子でない者に対して実行された場合[ArgumentError]が投げられます
  UnaryOperator get unaryOperator {
    switch (this) {
      default:
        if (isBinary) {
          throw ArgumentError.value(this, "$thisは単項演算子ではありません。");
        } else {
          throw UnimplementedError("$thisの演算はまだ実装されていません。");
        }
    }
  }
}

/// 演算子
enum operators {
  /// \+演算子
  add,

  /// \-演算子
  sub,

  /// ×演算子
  multi,

  /// ÷演算子
  div
}
