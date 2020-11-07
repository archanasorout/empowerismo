class SearchWordModel {
  String responseMessage;
  int responseCode;
  List<Resultt> result;

  SearchWordModel({this.responseMessage, this.responseCode, this.result});

  SearchWordModel.fromJson(Map<String, dynamic> json) {
    responseMessage = json['responseMessage'];
    responseCode = json['responseCode'];
    if (json['result'] != null) {
      result = new List<Resultt>();
      json['result'].forEach((v) {
        result.add(new Resultt.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseMessage'] = this.responseMessage;
    data['responseCode'] = this.responseCode;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Resultt {
  String word;

  Resultt({this.word});

  Resultt.fromJson(Map<String, dynamic> json) {
    word = json['word'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    return data;
  }
}
