import 'dart:math';
import 'package:calculator2022/model/operators.dart';

/// 半角空白で区切られた式を逆ポーランド記法に基づく配列に変換します
List<Term> parseStr2Polish(String formula) {
  return parseStrArr2Polish(formula.split(" "));
}

/// Stringの配列の式を逆ポーランド記法に基づく配列に変換します
List<Term> parseStrArr2Polish(List<String> formula) {
  final stack = <Operator>[];
  final result = <Term>[];

  // https://knowledge.sakura.ad.jp/220/
  // これを参考にスタックを使って実装した
  for (var term in formula) {
    final num = double.tryParse(term) ?? tryParseChars(term);
    if (num != null) {
      // 数字はresultに積む
      result.add(Term.fromNum(num));
      continue;
    }

    // 数字でないなら演算子であるはず
    final opr = parseStr2Opr(term);

    // )だけ一般化できないので別で実装する
    if (opr == Operators.rightBrace) {
      // ) が出てきたら ( が出てくるまでstackからresultに積む
      while (stack.isNotEmpty) {
        final lastTerm = stack.last;
        if (lastTerm == Operators.leftBrace) {
          stack.removeLast();
          break;
        }
        stack.removeLast();
        result.add(Term.fromOpr(lastTerm));
      }
      continue;
    }

    // その演算子より優先度の高いものをすべて全てresultに積む
    while (stack.isNotEmpty) {
      final lastTerm = stack.last;
      if (opr != Operators.leftBrace && lastTerm.priority > opr.priority) {
        result.add(Term.fromOpr(stack.removeLast()));
        continue;
      } else {
        break;
      }
    }

    stack.add(opr);
  }

  // stackに残ってる演算子をstackに積む
  while (stack.isNotEmpty) {
    var last = stack.removeLast();
    if (last == Operators.rightBrace) {
      continue;
    }
    result.add(Term.fromOpr(last));
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
      // 二項演算子の計算
      final right = stack.removeLast();
      final left = stack.removeLast();
      stack.add(item.operator.binaryOperator(left, right));
    } else if (item.isOperator && !item.operator.isBinary && stack.isNotEmpty) {
      // 単項演算子の計算
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

/// 特殊な文字を定数に変換します
double? tryParseChars(String source) {
  switch (source) {
    case "pi":
      return pi;
    case "e":
      return e;
    default:
      return null;
  }
}

/// 数式の数字又は演算子を表します
class Term {
  /// 演算子のときtrueを返します
  final bool isOperator;
  final double number;
  final Operator operator;

  /// 数字から数字の[Term]を生成します
  Term.fromNum(this.number)
      : isOperator = false,
        operator = 0;

  /// 演算子から演算子の[Term]を生成します
  Term.fromOpr(this.operator)
      : isOperator = true,
        number = 0;

  /// 演算子の文字列から演算子の[Term]を生成します
  ///
  /// 正しい演算子の形式の文字列でない場合は[ArgumentError]が投げられます
  Term.fromOprStr(String oprStr) : this.fromOpr(parseStr2Opr(oprStr));

  @override
  bool operator ==(covariant Term other) {
    return isOperator == other.isOperator &&
        number == other.number &&
        operator == other.operator;
  }

  @override
  int get hashCode {
    var result = 3;
    result = 31 * result + operator.hashCode;
    result = 31 * result + number.hashCode;
    result = 31 * result + isOperator.hashCode;
    return result;
  }
}
