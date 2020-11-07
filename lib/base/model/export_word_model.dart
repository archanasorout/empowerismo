class ExportWordModel {
  String responseMessage;
  int responseCode;
  String downloadUrl;

  ExportWordModel({this.responseMessage, this.responseCode, this.downloadUrl});

  ExportWordModel.fromJson(Map<String, dynamic> json) {
    responseMessage = json['responseMessage'];
    responseCode = json['responseCode'];
    downloadUrl = json['downloadUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseMessage'] = this.responseMessage;
    data['responseCode'] = this.responseCode;
    data['downloadUrl'] = this.downloadUrl;
    return data;
  }
}
