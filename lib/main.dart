import 'dart:async'; //Stream用
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//https://2357developnote.blogspot.com/2020/05/flutter-calculator1.htmlを参考。
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(), //メモリ部と数式表示部
        Keyboard(), //入力部
      ],
    )));
  }
}

//メモリと数式表示。TextFiledとTextFieldは誤字ではなく別物。
class TextField extends StatefulWidget {
  _TextFiledState createState() => _TextFiledState();
}

class _TextFiledState extends State<TextField> {
  String _expression = '';

  /////追加/////
  void _UpdateText(String letter) {
    setState(() {
      if (letter == '=' || letter == 'AC' || letter == '消')
        _expression = ''; //=またはACを押したら画面リセット
      else
        _expression += letter;
    });
  }

/////ここまで/////
  ///
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              _expression,
              style: TextStyle(
                fontSize: 64.0,
              ),
            ),
          ),
        ));
  }

  static final controller = StreamController<String>();

  ///Stream生成
  @override
  void initState() {
    controller.stream.listen((event) => _UpdateText(event));
  }
}

//キーボード
class Keyboard extends StatelessWidget {
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
              '√',
              'π',
              '^',
              'ページ切替',
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
        )));
  }
}

///キーボタン///
class Button extends StatelessWidget {
  final _key;
  Button(this._key);
  @override
  Widget build(BuildContext context) {
    return Container(
        //googleの円ボタン//
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
      ),
      child: Center(
        child: Text(
          _key,
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      onPressed: () {
        _TextFiledState.controller.sink.add(_key);
      },
    ));
  }
}
