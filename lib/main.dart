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
        TextFiled(), //メモリ部と数式表示部
        Keyboard(), //入力部
      ],
    )));
  }
}

//メモリと数式表示
class TextFiled extends StatefulWidget {
  _TextFiledState createState() => _TextFiledState();
}

class _TextFiledState extends State<TextField> {
  String _expression = '1+1';
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
            childAspectRatio: 1.3, // グリッドのサイズが正方形いっぱいにならないように
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
              '*',
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
              '×',
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

class Button extends StatelessWidget {
  final _key;
  Button(this._key);
  @override
  Widget build(BuildContext context) {
    return Container(
        //googleの円ボタン
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
      ),
      onPressed: () {},
      child: Center(
        child: Text(
          _key,
          style: TextStyle(fontSize: 25.0),
        ),
      ),
    ));
  }
}
