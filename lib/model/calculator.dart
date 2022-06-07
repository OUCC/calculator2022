typedef BinaryOperator = double Function(double left, double right);
typedef UnaryOperator = double Function(double arg);

List<Term> parseStrToPolish(String formula) {
  final terms = formula.split(' ');
  final stack = <String>[];
  final result = <Term>[];
  for (var term in terms) {
    final num = double.tryParse(term);
    if (num != null) {
      result.add(Term.fromNum(num));
      continue;
    }

    if (term == "+" || term == "-") {
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

  while (stack.isNotEmpty) {
    result.add(Term.fromOprStr(stack.removeLast()));
  }

  return result;
}

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

class Term {
  bool isOperator;
  double number = 0.0;
  operators operator = operators.add;

  Term.fromNum(this.number) : isOperator = false;
  Term.fromOpr(this.operator) : isOperator = true;
  Term.fromOprStr(String oprStr) : this.fromOpr(parseStrToOpr(oprStr));

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

extension OperatorEx on operators {
  bool get isBinary {
    return this == operators.add ||
        this == operators.sub ||
        this == operators.multi ||
        this == operators.div;
  }

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

enum operators { add, sub, multi, div }
