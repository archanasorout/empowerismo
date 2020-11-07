class AddToFavListModel {
  int responseCode;
  String responseMessage;
  Result result;

  AddToFavListModel({this.responseCode, this.responseMessage, this.result});

  AddToFavListModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String sId;
  String userId;
  String listName;
  String labelColor;
  List<Words> words;
  int wordCount;

  Result(
      {this.sId,
        this.userId,
        this.listName,
        this.labelColor,
        this.words,
        this.wordCount});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['user_id'];
    listName = json['list_name'];
    labelColor = json['label_color'];
    if (json['words'] != null) {
      words = new List<Words>();
      json['words'].forEach((v) {
        words.add(new Words.fromJson(v));
      });
    }
    wordCount = json['word_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user_id'] = this.userId;
    data['list_name'] = this.listName;
    data['label_color'] = this.labelColor;
    if (this.words != null) {
      data['words'] = this.words.map((v) => v.toJson()).toList();
    }
    data['word_count'] = this.wordCount;
    return data;
  }
}

class Words {
  String wordId;
  String word;
  String translation;
  String sourceLang;
  String targetLang;
  String sId;

  Words(
      {this.wordId,
        this.word,
        this.translation,
        this.sourceLang,
        this.targetLang,
        this.sId});

  Words.fromJson(Map<String, dynamic> json) {
    wordId = json['word_id'];
    word = json['word'];
    translation = json['translation'];
    sourceLang = json['source_lang'];
    targetLang = json['target_lang'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word_id'] = this.wordId;
    data['word'] = this.word;
    data['translation'] = this.translation;
    data['source_lang'] = this.sourceLang;
    data['target_lang'] = this.targetLang;
    data['_id'] = this.sId;
    return data;
  }
}
