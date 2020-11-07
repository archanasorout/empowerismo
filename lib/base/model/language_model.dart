class LanguageModel {
  String responseMessage;
  int responseCode;
  List<LanguageList> languageList;

  LanguageModel({this.responseMessage, this.responseCode, this.languageList});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    responseMessage = json['responseMessage'];
    responseCode = json['responseCode'];
    if (json['languageList'] != null) {
      languageList = new List<LanguageList>();
      json['languageList'].forEach((v) {
        languageList.add(new LanguageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseMessage'] = this.responseMessage;
    data['responseCode'] = this.responseCode;
    if (this.languageList != null) {
      data['languageList'] = this.languageList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LanguageList {
  String sourceLanguage;
  String targetLanguage;
  String targetLanguageLocalised;
  String targetLanguageFlag;

  LanguageList(
      {this.sourceLanguage,
        this.targetLanguage,
        this.targetLanguageLocalised,
        this.targetLanguageFlag});

  LanguageList.fromJson(Map<String, dynamic> json) {
    sourceLanguage = json['source_language'];
    targetLanguage = json['target_language'];
    targetLanguageLocalised = json['target_language_localised'];
    targetLanguageFlag = json['target_language_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source_language'] = this.sourceLanguage;
    data['target_language'] = this.targetLanguage;
    data['target_language_localised'] = this.targetLanguageLocalised;
    data['target_language_flag'] = this.targetLanguageFlag;
    return data;
  }
}
