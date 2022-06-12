import 'dart:ffi';
import 'dart:math';
import 'package:calculator2022/model/calculator.dart';

import 'operators.dart';
import 'package:flutter_test/flutter_test.dart';

typedef FractionOperater = List Function(List left, List right);
typedef frac = List<double>;

final Map<Operator, FractionOperater> fruction_binaryOprFuncMap = {
  0x100: (left, right) =>
      [left[0] * right[1] + right[0] * left[1], left[1] * right[1]],
  0x101: (left, right) =>
      [left[0] * right[1] - right[0] * left[1], left[1] * right[1]],
  0x110: (left, right) => [left[0] * right[0], left[1] * right[1]],
  0x111: (left, right) => [left[0] * right[1], left[1] * right[0]],
  //0x120: (left, right) => pow(left, right).toDouble()
};

final Map<Operator, UnaryOperator> fruction_unaryOprFuncMap = {
  0x2F0: (arg) => sin(arg), // 弧度法
  0x2F1: (arg) => cos(arg),
  0x2F2: (arg) => tan(arg),
  0x2F3: (arg) => log(arg),
  0x2F4: (arg) => log(arg) / ln10,
  0x2F5: (arg) => sqrt(arg),
};

List Fraction(List<Term> terms) {
  final stack = <List>[];
  while (true) {
    final item = terms.removeAt(0);
    if (!item.isOperator) {
      stack.add([item.number, 1]);
    } else if (item.isOperator && item.operator.isBinary && stack.length >= 2) {
      // 二項演算子の計算
      final right = stack.removeLast();
      final left = stack.removeLast();
      stack.add(item.operator.f_binaryOperator(left, right));
    } /*else if (item.isOperator && !item.operator.isBinary && stack.isNotEmpty) {
      // 単項演算子の計算
      final arg = stack.removeLast();
      stack.add(item.operator.unaryOperator(arg));
    } */
    else {
      throw ArgumentError.value(terms, "termsの形式が正しくありません。");
    }
    if (terms.isEmpty) {
      break;
    }
  }
  if (stack.length > 1) {
    throw ArgumentError.value(terms, "termsの形式が正しくありません。");
  }
  final res = stack.first;
  final result = Reduce(res);
  return result;
}

///作られた分数を約分します
List Reduce(List res) {
  double nume, deno, r;
  int length_afterpoint;
  nume = res[0];
  deno = res[1];
  final demolength = nume - deno.toInt();
  final numelength = nume - deno.toInt();
  if (deno == 0) {
    throw ArgumentError("分数の分子が0です");
  }
  if (demolength.toString().length >= numelength.toString().length) {
    length_afterpoint = demolength.toString().length;
  } else {
    length_afterpoint = numelength.toString().length;
  }

  for (int i = 0; i < length_afterpoint - 2; i++) {
    nume *= 10;
    deno *= 10;
  }
  //int nume = a.toInt();
  //int deno = b.toInt();
  if (nume != 0) {
    num dive = gcd(nume, deno).abs();
    nume /= dive;
    deno /= dive;
  }
  final result = [nume, deno];

  return result;
}
///2数の最大公約数を返します
num gcd(num a, num b) {
  return ((a % b) == 0) ? b : gcd(b, (a % b));
}

double lcm(num a, num b) {
  return (a * b) / gcd(a, b);
}

typedef F_BinaryOperator = Function(List, List);

extension Foperator on Operator {
  F_BinaryOperator get f_binaryOperator {
    if (!isBinary) {
      throw ArgumentError.value(this, "$thisは二項演算子ではありません。");
    }
    var func = fruction_binaryOprFuncMap[this];
    if (func == null) {
      throw UnimplementedError("$thisの演算はまだ実装されていません。");
    }
    return func;
  }
}
