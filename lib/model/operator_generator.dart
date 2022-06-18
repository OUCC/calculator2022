import 'dart:math';
import 'expression_builder.dart';
import 'operators.dart';

UnaryOperator parseStr2Func(String source, [String argName = "x"]) {
  return parseStrArr2Func(source.split(" "), argName);
}

/// [argName]: 引数の名前
UnaryOperator parseStrArr2Func(List<String> source, [String argName = "x"]) {
  final terms = _parseStrArr2Polish(source);
  return buildUnaryOperator(terms);
}

UnaryOperator buildUnaryOperator(List<_Term> terms) {
  final stack = <_Term>[];

  while (true) {
    final item = terms.removeAt(0);
    if (item.type != _TermType.operator) {
      stack.add(item);
    } else if (item.operator.isBinary && stack.length >= 2) {
      // 二項演算子の計算
      final right = stack.removeLast();
      final left = stack.removeLast();

      // right leftのどれが変数でもいいようにする
      if (right.isVariant && left.isVariant) {
        right.builder?.addBuilderBinaryOpr(item.operator, left.builder, true);
        stack.add(right);
      } else if (right.isVariant) {
        right.builder?.addBinaryOpr(item.operator, left.value, true);
        stack.add(right);
      } else if (left.isVariant) {
        left.builder?.addBinaryOpr(item.operator, right.value, false);
        stack.add(left);
      } else {
        stack.add(_Term.fromNum(
            item.operator.binaryOperator(left.value, right.value)));
      }
    } else if (!item.operator.isBinary && stack.isNotEmpty) {
      // 単項演算子の計算
      final arg = stack.removeLast();
      if (arg.isVariant) {
        arg.builder?.addUnaryOpr(item.operator);
        stack.add(arg);
      } else {
        stack.add(_Term.fromNum(item.operator.unaryOperator(arg.value)));
      }
    } else {
      throw ArgumentError.value(terms, "sourceの形式が正しくありません。");
    }
    if (terms.isEmpty) {
      break;
    }
  }
  if (stack.length != 1) {
    throw ArgumentError.value(terms, "sourceの形式が正しくありません。");
  }
  if (stack.first.isVariant) {
    final ret = stack.first.builder?.func;
    if (ret == null) {
      throw ArgumentError.value(terms, "sourceの形式が正しくありません。");
    }
    return ret;
  } else {
    return (arg) => stack.first.value;
  }
}

List<_Term> _parseStrArr2Polish(List<String> source, [String argName = "x"]) {
  final stack = <Operator>[];
  final result = <_Term>[];

  // https://knowledge.sakura.ad.jp/220/
  // これを参考にスタックを使って実装した
  for (var term in source) {
    final num = double.tryParse(term) ?? tryParseChars(term);
    if (num != null) {
      // 数字はresultに積む
      result.add(_Term.fromNum(num));
      continue;
    }

    if (term == argName) {
      result.add(_Term.fromVariant());
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
        result.add(_Term.fromOpr(lastTerm));
      }
      continue;
    }

    // その演算子より優先度の高いものをすべて全てresultに積む
    while (stack.isNotEmpty) {
      final lastTerm = stack.last;
      if (opr != Operators.leftBrace && lastTerm.priority > opr.priority) {
        result.add(_Term.fromOpr(stack.removeLast()));
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
    result.add(_Term.fromOpr(last));
  }

  return result;
}

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

class _Term {
  final _TermType type;
  final double value;
  final Operator operator;
  final UnaryOperatorBuilder? builder;
  bool get isVariant => type == _TermType.variant;
  _Term.fromVariant()
      : type = _TermType.variant,
        value = 0,
        operator = 0,
        builder = UnaryOperatorBuilder();
  _Term.fromNum(this.value)
      : type = _TermType.constant,
        operator = 0,
        builder = null;
  _Term.fromOpr(this.operator)
      : type = _TermType.operator,
        value = 0,
        builder = null;
}

enum _TermType { variant, operator, constant }
