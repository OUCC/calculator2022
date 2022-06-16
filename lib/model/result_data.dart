class ResultData {
  /// id
  final int id;

  /// 半角空白を区切り文字とした式
  final String formula;

  /// 計算結果
  final double result;

  /// 作成された日時
  final DateTime createdDate;

  ResultData(this.id, this.formula, this.result, this.createdDate);

  /// 式の配列から`ResultDataを生成します。
  ResultData.fromList(
      this.id, List<String> formulaList, this.result, this.createdDate)
      : formula = formulaList.join(" ");

  /// JSONをデコードして出てきた`Map<String, dynamic>`から[ResultData]を生成します。
  ResultData.fromJson(Map<String, dynamic> json)
      : id = json[keyId.jsonKeyName],
        formula = json[keyFormula.jsonKeyName],
        result = json[keyResult.jsonKeyName],
        createdDate = json[keyCreatedDate.jsonKeyName];

  /// JSONへエンコードするためにデータを変換します。
  Map<String, dynamic> toJson() => {
        keyId.jsonKeyName.toString(): id,
        keyFormula.jsonKeyName.toString(): formula,
        keyResult.jsonKeyName.toString(): result,
        keyCreatedDate.jsonKeyName.toString(): createdDate,
      };
}

//列挙型を使ってキー用の文字列を取得出来るようにする
enum JsonKey { id, formula, result, createdDate }

extension TypeExtension on JsonKey {
  static final Map<Enum, String> jsonKeyNames = {
    JsonKey.id: "id",
    JsonKey.formula: "formula",
    JsonKey.result: "result",
    JsonKey.createdDate: "created_date"
  };
  //何故かString?にしないとエラーがでます。この？は何の意味？
  String? get jsonKeyName => jsonKeyNames[this];
}

//ここで宣言するのは多分良くない事
JsonKey keyId = JsonKey.id;
JsonKey keyFormula = JsonKey.formula;
JsonKey keyResult = JsonKey.result;
JsonKey keyCreatedDate = JsonKey.createdDate;
