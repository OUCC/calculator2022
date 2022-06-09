//import 'package:calculator2022/model/calculator.dart';
import 'dart:math';
import 'dart:core';

String Fanction(String fanction) {
  //関数について計算する関数
  //関数は「関数名|入力」(底がeでないlogは「log|底|対数」)で入力
  //関数内に四則演算がある場合はcalculatorで計算可能（現在はコメントアウトしてある）
  //現在はsin,cos,tan,e^,logを実装済み

  //関数を"|"で分割し数列termsに、termsの長さをlengthに入れlensthの長さにより関数の大まかな種類を識別
  final terms = fanction.split("|");
  final length = terms.length;
  var result;
  final anser;
  if (length <= 1 || length >= 4) {
    result = "エラーが発生しました、正しい形式で入力してください";
  } else {
    final a;
    final b;
    final rad;
    //小数点以下何桁まで残すか
    final digit = 2;
    try {
      //1変数関数の処理、現在sin、cos、tan、e^、底がeのlog

      //final stack_a = parseStrToPolish(terms[1]);
      //a = calculate(stack_a);
      a = double.parse(terms[1]);
      rad = a * (pi / 180);

      if (length == 2) {
        switch (terms[0]) {
          case "sin":
            result = sin(rad).toStringAsFixed(digit);
            break;
          case "cos":
            result = cos(rad).toStringAsFixed(digit);
            break;
          case "tan":
            result = tan(rad).toStringAsFixed(digit);
            break;
          case "e":
            result = exp(a).toStringAsFixed(digit);
            break;
          case "log":
            result = log(a).toStringAsFixed(digit);
            break;
          default:
            result = "エラーが発生しました、有効な関数を入力してください";
            break;
        }
      }

      if (length == 3) {

        //2変数関数用の処理、現在底アリのlog

        //final stack_b = parseStrToPolish(terms[2]);
        //b = calculate(stack_b);

        
        b = double.parse(terms[2]);

        switch (terms[0]) {
          case "log":
            result = (log(b) / log(a)).toStringAsFixed(digit);
            break;

          default:
            result = "エラーが発生しました、有効な関数を入力してください";
            break;
        }
      }
    } catch (exception) {
      result = "エラーが発生しました、有効な数値を入力してください";
    }
  }

  return result;
}
