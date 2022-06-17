import 'dart:convert';
import 'dart:io'; //File classを使うのに必要(mainにも必要)
import 'package:path_provider/path_provider.dart'; //AppPathを取得するのに必要：ライブラリのインストールしてね
import 'dart:async'; //非同期処理用(mainにも必要)

//usage
//void main() async{
//  File file = await fileOpen("fileName");
// }

//{read,write}As{Bytes,Lines,String}{Sync}が使えて、Syncを使うと同期処理になる(await要らなくなる)

//Future<String> readAsString({Encoding encoding = utf8});文字列としてファイルの全部を入力

//Future<File> writeAsString(String contents, {FileMode mode = FileMode.write,Encoding encoding = utf8,bool flush = false});
//で、文字列のファイル出力 FileMode.append で追加書き込みになる

//openRead,openWrite は、Streamというもの扱うらしい
//open, closeは、RandomAccessFileというものを扱うらしい
//わからない。詳しくはhttps://api.flutter.dev/flutter/dart-io/File-class.html

//端末上で、アプリが永続的に使えるパスを取得して文字列で返す(外から使わない・使えない)
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

//ファイル名を指定して、アプリ用のファイルを取得
//アプリをアンインスールするとファイルも消える
//閉じなくていい
Future<File> _fileOpen(String fileName) async {
  final path = await _localPath;
  return File(path + "/" + fileName);
}

//実用的なテキストファイルの保存用クラス
class TextSave {
  String fileName = ""; //ファイル名で、拡張子込み
  String writeString = ""; //ファイルに書き込む文字列
  File? file; //書き込むファイル

  //作るときにファイル名を指定します。
  TextSave(String fileName) {
    this.fileName = fileName;
  }

  //計算するごとにこれを呼び出してあげれば、計算の履歴を貯めていきます。
  void textAdd(Map<String, dynamic> json) {
    writeString = writeString +
        json["formula"] +
        "\n" +
        json["result"] +
        "\n" +
        "\n"; //式と改行して結果を出力してまた改行
  }

  //テキストファイルに上書き保存（基本）
  Future save() async {
    file = await _fileOpen(fileName.toString());
    file = await file?.writeAsString(writeString,
        mode: FileMode.write, encoding: utf8, flush: false);
  }

  //テキストファイルに追記保存
  Future saveApend() async {
    file = await _fileOpen(fileName.toString());
    file = await file?.writeAsString(writeString,
        mode: FileMode.append, encoding: utf8, flush: false);
  }
}

//非推奨な保存方法。どんどんストレージを圧迫する
//jsonのmapを受け取って、計算式と結果だけをテキストファイルに追記する
//引数：map型のjson, テキストファイルの名前
Future<String> saveText(Map<String, dynamic> json, fileName) async {
  String writeString; //書き込む文字列
  File file = await _fileOpen(fileName); //ファイルを取得

  writeString =
      json["formula"] + "\n" + json["result"] + "\n" + "\n"; //式と改行して結果を出力してまた改行
  file = await file.writeAsString(writeString,
      mode: FileMode.append, encoding: utf8, flush: false);
  return file.path;
}
