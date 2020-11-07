class SelectWordModel {
  String responseMessage;
  int responseCode;
  ResultOfSelectWord result;
  bool favourited;
  int totalSearches;
  int searchRemaining;

  SelectWordModel(
      {this.responseMessage,
        this.responseCode,
        this.result,
        this.favourited,
        this.totalSearches,
        this.searchRemaining});

  SelectWordModel.fromJson(Map<String, dynamic> json) {
    responseMessage = json['responseMessage'];
    responseCode = json['responseCode'];
    result =
    json['result'] != null ? new ResultOfSelectWord.fromJson(json['result']) : null;
    favourited = json['favourited'];
    totalSearches = json['total_searches'];
    searchRemaining = json['search_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseMessage'] = this.responseMessage;
    data['responseCode'] = this.responseCode;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['favourited'] = this.favourited;
    data['total_searches'] = this.totalSearches;
    data['search_remaining'] = this.searchRemaining;
    return data;
  }
}

class ResultOfSelectWord {
  String sourceUsage;
  String targetUsage;
  String sourceLangPronunciation;
  String targetLangPronunciation;
 // List<Null> pictures;
  String sId;
  String word;
  String translation;
  String sourceLang;
  String targetLang;

  ResultOfSelectWord(
      {this.sourceUsage,
        this.targetUsage,
        this.sourceLangPronunciation,
        this.targetLangPronunciation,
       // this.pictures,
        this.sId,
        this.word,
        this.translation,
        this.sourceLang,
        this.targetLang});

  ResultOfSelectWord.fromJson(Map<String, dynamic> json) {
    sourceUsage = json['source_usage'];
    targetUsage = json['target_usage'];
    sourceLangPronunciation = json['source_lang_pronunciation'];
    targetLangPronunciation = json['target_lang_pronunciation'];
  /*  if (json['pictures'] != null) {
      pictures = new List<Null>();
      json['pictures'].forEach((v) {
        pictures.add(new Null.fromJson(v));
      });
    }*/
    sId = json['_id'];
    word = json['word'];
    translation = json['translation'];
    sourceLang = json['source_lang'];
    targetLang = json['target_lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source_usage'] = this.sourceUsage;
    data['target_usage'] = this.targetUsage;
    data['source_lang_pronunciation'] = this.sourceLangPronunciation;
    data['target_lang_pronunciation'] = this.targetLangPronunciation;
    /*if (this.pictures != null) {
      data['pictures'] = this.pictures.map((v) => v.toJson()).toList();
    }*/
    data['_id'] = this.sId;
    data['word'] = this.word;
    data['translation'] = this.translation;
    data['source_lang'] = this.sourceLang;
    data['target_lang'] = this.targetLang;
    return data;
  }
}
