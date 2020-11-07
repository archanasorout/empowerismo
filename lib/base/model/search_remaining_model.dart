class SearchRemainingModel {
  String responseMessage;
  int responseCode;
  int searchRemaining;

  SearchRemainingModel(
      {this.responseMessage, this.responseCode, this.searchRemaining});

  SearchRemainingModel.fromJson(Map<String, dynamic> json) {
    responseMessage = json['responseMessage'];
    responseCode = json['responseCode'];
    searchRemaining = json['search_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responseMessage'] = this.responseMessage;
    data['responseCode'] = this.responseCode;
    data['search_remaining'] = this.searchRemaining;
    return data;
  }
}
