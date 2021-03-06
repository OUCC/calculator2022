import 'dart:async'; //Stream用
import 'package:calculator2022/model/calculator.dart';
import 'package:calculator2022/model/save_data.dart';
import 'package:flutter/material.dart';

//最初の画面表示（キーボード切替をする前）

void main() {
  runApp(const MyApp());
}

//https://2357developnote.blogspot.com/2020/05/flutter-calculator1.htmlを参考。雛形作成。
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const MemoryField(), //メモリ部
        const TextField(), //数式表示部
        Keyboard(), //入力部1枚目
      ],
    )));
  }
}

//メモリ部。
class MemoryField extends StatefulWidget {
  const MemoryField({Key? key}) : super(key: key);

  @override
  _MemoryFiledState createState() => _MemoryFiledState();
}

//メモリ部の続き。とりあえず数式表示部と同じ構造にするのがいいかな？
class _MemoryFiledState extends State<MemoryField> {
  final String _expression = '1+1=2';
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          color: const Color(0xff87cefa),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              _expression,
              style: const TextStyle(
                fontSize: 30.0,
              ),
            ),
          ),
        ));
  }
}

//数式表示部。TextFiledとTextFieldは誤字ではなく別物。
class TextField extends StatefulWidget {
  const TextField({Key? key}) : super(key: key);

  @override
  _TextFiledState createState() => _TextFiledState();
}

const _numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ".", ":"];

class _TextFiledState extends State<TextField> {
  String _expression = '';

  /////追加/////
  void _updateText(String letter) async {
    late String setString;
    if (letter == "=") {
      final result = calculate(parseStr2Polish(_expression
          .replaceAll("÷", "/")
          .replaceAll("×", "*")
          .replaceAll("π", "pi")
          .replaceAll("√", "sqrt")));
      setString = result.toString();
      await addResultData(_expression, result); // なんかエラー
    } else if (letter == "AC") {
      setString = "";
    } else if (letter == "消") {
      final temp = _expression.trim();
      setString = temp.substring(0, temp.length - 1).trimRight();
    } else if (_expression.isEmpty) {
      setString = letter;
    } else if (_numbers.contains(letter)) {
      if (_numbers
          .contains(_expression.trim().substring(_expression.length - 1))) {
        setString = "$_expression$letter";
      } else {
        setString = "$_expression $letter";
      }
    } else {
      setString = "$_expression $letter";
    }
    setState(() {
      _expression = setString;
    });
  }

/////ここまで/////
  ///
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Align(
          alignment: Alignment.centerRight, //右詰め
          child: Text(
            _expression,
            style: const TextStyle(
              fontSize: 64.0,
            ),
          ),
        ));
  }

  static final controller = StreamController<String>();

  //Stream生成
  @override
  void initState() {
    super.initState();
    controller.stream.listen((event) => _updateText(event));
  }
}

//キーボード1枚目
class Keyboard extends StatefulWidget {
  Keyboard({Key? key}) : super(key: key);

  @override
  _KeyboardState createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  bool switchBool = true;
  void _onPressedStart() {
    setState(() {
      switchBool = !switchBool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5, //高さの割合
        child: Column(children: <Widget>[
          ElevatedButton(
            onPressed: _onPressedStart,
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            child: const Text('キーボード切替'),
          ),
          if (switchBool) //初期のキーボード
            Expanded(
                child: Center(
                    child: Container(
              color: const Color(0xff87cefa),
              child: GridView.count(
                childAspectRatio:
                    1.5, // グリッドのサイズが正方形いっぱいにならないように。大きいほどサイズが小さくなる。
                crossAxisCount: 4, //一行に4個表示
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                children: [
                  '√',
                  'pi',
                  '^',
                  'rd', //乱数
                  'AC',
                  '(',
                  ')',
                  '÷',
                  '7',
                  '8',
                  '9',
                  '×',
                  '4',
                  '5',
                  '6',
                  '-',
                  '1',
                  '2',
                  '3',
                  '+',
                  '0',
                  '.',
                  '消',
                  '=',
                ].map((key) {
                  return GridTile(
                    child: Button(key),
                  );
                }).toList(),
              ),
            )))
          else //キーボード2枚目
            Expanded(
                child: Center(
                    child: Container(
              color: const Color(0xff87cefa),
              child: GridView.count(
                childAspectRatio:
                    1.5, // グリッドのサイズが正方形いっぱいにならないように。大きいほどサイズが小さくなる。
                crossAxisCount: 4, //一行に4個表示
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                children: [
                  'sin',
                  'cos',
                  'tan',
                  ':', //時間用
                  'AC',
                  'e',
                  '//', //抵抗並列用演算子
                  '÷',
                  '7',
                  '8',
                  '9',
                  '×',
                  '4',
                  '5',
                  '6',
                  '-',
                  '1',
                  '2',
                  '3',
                  '+',
                  '0',
                  '.',
                  '消',
                  '=',
                ].map((key) {
                  return GridTile(
                    child: Button(key),
                  );
                }).toList(),
              ),
            )))
        ]));
  }
}

//キーボード2枚目
class Keyboard2 extends StatelessWidget {
  const Keyboard2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Center(
            child: Container(
          color: const Color(0xff87cefa),
          child: GridView.count(
            childAspectRatio: 1.5, // グリッドのサイズが正方形いっぱいにならないように。大きいほどサイズが小さくなる。
            crossAxisCount: 4, //一行に4個表示
            mainAxisSpacing: 3.0,
            crossAxisSpacing: 3.0,
            children: [
              'sin',
              'cos',
              'tan',
              ':', //時間用
              'AC',
              'e',
              '//', //抵抗並列用演算子
              '÷',
              '7',
              '8',
              '9',
              '×',
              '4',
              '5',
              '6',
              '-',
              '1',
              '2',
              '3',
              '+',
              '0',
              '.',
              '消',
              '=',
            ].map((key) {
              return GridTile(
                child: Button(key),
              );
            }).toList(),
          ),
        )));
  }
}

///キーボタン///
class Button extends StatelessWidget {
  final _key;
  const Button(this._key, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Center(
        child: Text(
          _key,
          style: const TextStyle(fontSize: 32.0, color: Colors.blueGrey),
        ),
      ),
      onPressed: () {
        _TextFiledState.controller.sink.add(_key);
      },
    );
  }
}
