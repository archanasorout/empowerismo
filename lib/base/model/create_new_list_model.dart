class CreateNewListModel {
  String responseMessage;
  int responseCode;

  CreateNewListModel({this.responseMessage, this.responseCode});

  CreateNewListModel.fromJson(Map<String, dynamic> json) {
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