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
Future<File> fileOpen(String fileName) async {
  final path = await _localPath;
  return File(path + "/" + fileName);
}
