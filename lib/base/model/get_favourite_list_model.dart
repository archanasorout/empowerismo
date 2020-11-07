class FavouriteModel {
  String responseMessage;
  int responseCode;
  List<FavouriteList> favouriteList;

  FavouriteModel({this.responseMessage, this.responseCode, this.favouriteList});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    responseMessage = json['responseMessage'];
    responseCode = json['responseCode'];
    if (json['favouriteList'] != null) {
      favouriteList = new List<FavouriteList>();
      json['favouriteList'].forEach((v) {
        favouriteList.add(new FavouriteList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseMessage'] = this.responseMessage;
    data['responseCode'] = this.responseCode;
    if (this.favouriteList != null) {
      data['favouriteList'] =
          this.favouriteList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavouriteList {
  String sId;
  String userId;
  String listName;
  String labelColor;
  List<Words> words;
  int wordCount;

  FavouriteList(
      {this.sId,
        this.userId,
        this.listName,
        this.labelColor,
        this.words,
        this.wordCount});

  FavouriteList.fromJson(Map<String, dynamic> json) {
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
