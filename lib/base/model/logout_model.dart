class LogoutModel {
  String responseMessage;
  int responseCode;

  LogoutModel({this.responseMessage, this.responseCode});

  LogoutModel.fromJson(Map<String, dynamic> json) {
    responseMessage = json['responseMessage'];
    responseCode = json['responseCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseMessage'] = this.responseMessage;
    data['responseCode'] = this.responseCode;
    return data;
  }
}
