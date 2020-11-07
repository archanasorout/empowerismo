class ForgotPasswordModel {
  int responseCode;
  String responseMessage;
  String userId;

  ForgotPasswordModel({this.responseCode, this.responseMessage, this.userId});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['user_id'] = this.userId;
    return data;
  }
}
