// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:math' as math;
import 'operators.dart';

class UnaryOperatorBuilder {
  UnaryOperator _unaryOperator;
  UnaryOperator get func => _unaryOperator;
  UnaryOperatorBuilder() : _unaryOperator = ((arg) => arg);

  void addBinaryOpr(Operator opr, double val, bool valIsLeft) {
    switch (opr) {
      case Operators.add:
        add(val);
        break;
      case Operators.sub:
        sub(val, valIsLeft);
        break;
      case Operators.multi:
        multi(val);
        break;
      case Operators.div:
        div(val, valIsLeft);
        break;
      case Operators.pow:
        pow(val, valIsLeft);
        break;
      default:
        throw ArgumentError("引数が制約に違反しています");
    }
  }

  void addBuilderBinaryOpr(
      Operator opr, UnaryOperatorBuilder? builder, bool builderIsLeft) {
    if (builder == null) {
      throw NullThrownError();
    }
    switch (opr) {
      case Operators.add:
        addBuilder(builder);
        break;
      case Operators.sub:
        subBuilder(builder, builderIsLeft);
        break;
      case Operators.multi:
        multiBuilder(builder);
        break;
      case Operators.div:
        divBuilder(builder, builderIsLeft);
        break;
      case Operators.pow:
        powBuilder(builder, builderIsLeft);
        break;
      default:
        throw ArgumentError("引数が制約に違反しています");
    }
  }

  void addUnaryOpr(Operator opr) {
    switch (opr) {
      case Operators.sin:
        sin();
        break;
      case Operators.cos:
        cos();
        break;
      case Operators.tan:
        tan();
        break;
      case Operators.ln:
        ln();
        break;
      case Operators.log:
        log();
        break;
      case Operators.sqrt:
        sqrt();
        break;
      default:
        throw ArgumentError("引数が制約に違反しています");
    }
  }

  UnaryOperator add(double val) {
    final temp = _unaryOperator;
    return _unaryOperator = ((arg) => temp(arg) + val);
  }

  /// 引き算 [valIsLeft]が`true`のとき[val]-argになります。
  UnaryOperator sub(double val, bool valIsLeft) {
    final tempUnaryOpr = _unaryOperator;
    return _unaryOperator = valIsLeft
        ? (arg) => val - tempUnaryOpr(arg)
        : (arg) => tempUnaryOpr(arg) - val;
  }

  UnaryOperator multi(double val) {
    final temp = _unaryOperator;
    return _unaryOperator = (arg) => temp(arg) * val;
  }

  /// 割り算 [valIsLeft]が`true`のとき[val]/argになります。
  UnaryOperator div(double val, bool valIsLeft) {
    final temp = _unaryOperator;
    return valIsLeft
        ? _unaryOperator = ((arg) => val / temp(arg))
        : _unaryOperator = ((arg) => temp(arg) / val);
  }

  /// 累乗 [valIsLeft]が`true`の時[val]が左(底)
  UnaryOperator pow(double val, bool valIsLeft) {
    final temp = _unaryOperator;
    return valIsLeft
        ? _unaryOperator = ((arg) => math.pow(val, temp(arg)).toDouble())
        : _unaryOperator = ((arg) => math.pow(temp(arg), val).toDouble());
  }

  UnaryOperator sin() {
    final temp = _unaryOperator;
    return _unaryOperator = ((arg) => math.sin(temp(arg)));
  }

  UnaryOperator cos() {
    final temp = _unaryOperator;
    return _unaryOperator = ((arg) => math.cos(temp(arg)));
  }

  UnaryOperator tan() {
    final temp = _unaryOperator;
    return _unaryOperator = ((arg) => math.tan(temp(arg)));
  }

  UnaryOperator ln() {
    final temp = _unaryOperator;
    return _unaryOperator = ((arg) => math.log(temp(arg)));
  }

  UnaryOperator log() {
    final temp = _unaryOperator;
    return _unaryOperator = ((arg) => math.log(temp(arg)) / math.ln10);
  }

  UnaryOperator sqrt() {
    final temp = _unaryOperator;
    return _unaryOperator = ((arg) => math.sqrt(temp(arg)));
  }

  UnaryOperator addBuilder(UnaryOperatorBuilder builder) {
    final temp = _unaryOperator;
    return _unaryOperator = ((arg) => temp(arg) + builder.func(arg));
  }

  /// 引き算 [builderIsLeft]が`true`のとき[builder]-argになります。
  UnaryOperator subBuilder(UnaryOperatorBuilder builder, bool builderIsLeft) {
    final temp = _unaryOperator;
    return builderIsLeft
        ? _unaryOperator = ((arg) => builder.func(arg) - temp(arg))
        : _unaryOperator = ((arg) => temp(arg) - builder.func(arg));
  }

  UnaryOperator multiBuilder(UnaryOperatorBuilder builder) {
    final temp = _unaryOperator;
    return _unaryOperator = ((arg) => temp(arg) * builder.func(arg));
  }

  /// 割り算 [builderIsLeft]が`true`のとき[builder]/argになります。
  UnaryOperator divBuilder(UnaryOperatorBuilder builder, bool builderIsLeft) {
    final temp = _unaryOperator;
    return builderIsLeft
        ? _unaryOperator = ((arg) => builder.func(arg) / temp(arg))
        : _unaryOperator = ((arg) => temp(arg) / builder.func(arg));
  }

  /// 累乗 [builderIsLeft]が`true`の時[builder]が指数
  UnaryOperator powBuilder(UnaryOperatorBuilder builder, bool builderIsLeft) {
    final temp = _unaryOperator;
    return _unaryOperator = builderIsLeft
        ? ((arg) => math.pow(builder.func(arg), temp(arg)).toDouble())
        : ((arg) => math.pow(temp(arg), builder.func(arg)).toDouble());
  }

  /// [_unaryOperator]を実行した後、その返り値を引数に[func]を実行します
  UnaryOperator addFuncAfterOperator(UnaryOperator func) {
    final temp = _unaryOperator;
    return _unaryOperator = ((arg) => func(temp(arg)));
  }

  /// [func]を実行した後、その返り値を引数に[_unaryOperator]を実行します
  UnaryOperator addFuncBeforeOperator(UnaryOperator func) {
    final temp = _unaryOperator;
    return _unaryOperator = ((arg) => temp(func(arg)));
  }
}
