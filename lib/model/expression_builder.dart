import 'dart:math' as math;
import 'operators.dart';

class UnaryOperatorBuilder {
  UnaryOperator _unaryOperator;
  UnaryOperator get func => _unaryOperator;
  UnaryOperatorBuilder() : _unaryOperator = ((arg) => arg);

  UnaryOperator add(double val) =>
      _unaryOperator = ((arg) => _unaryOperator(arg) + val);

  /// 引き算 [valIsLeft]が`true`のとき[val]-argになります。
  UnaryOperator sub(double val, bool valIsLeft) => valIsLeft
      ? _unaryOperator = ((arg) => val - _unaryOperator(arg))
      : _unaryOperator = ((arg) => _unaryOperator(arg) - val);

  UnaryOperator multi(double val) =>
      _unaryOperator = ((arg) => _unaryOperator(arg) * val);

  /// 割り算 [valIsLeft]が`true`のとき[val]/argになります。
  UnaryOperator div(double val, bool valIsLeft) => valIsLeft
      ? _unaryOperator = ((arg) => val / _unaryOperator(arg))
      : _unaryOperator = ((arg) => _unaryOperator(arg) / val);

  /// 累乗 [valIsExponent]が`true`の時[val]が指数
  UnaryOperator pow(double val, bool valIsExponent) => valIsExponent
      ? _unaryOperator = ((arg) => math.pow(arg, val).toDouble())
      : _unaryOperator = ((arg) => math.pow(val, arg).toDouble());
  UnaryOperator sin() =>
      _unaryOperator = ((arg) => math.sin(_unaryOperator(arg)));
  UnaryOperator cos() =>
      _unaryOperator = ((arg) => math.cos(_unaryOperator(arg)));
  UnaryOperator tan() =>
      _unaryOperator = ((arg) => math.tan(_unaryOperator(arg)));
  UnaryOperator ln() =>
      _unaryOperator = ((arg) => math.log(_unaryOperator(arg)));
  UnaryOperator log() =>
      _unaryOperator = ((arg) => math.log(_unaryOperator(arg)) / math.ln10);
  UnaryOperator sqrt() =>
      _unaryOperator = ((arg) => math.sqrt(_unaryOperator(arg)));
}
