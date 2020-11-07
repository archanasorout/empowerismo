class VerifyOtpModel {
  int responseCode;
  String responseMessage;
  Result result;

  VerifyOtpModel({this.responseCode, this.responseMessage, this.result});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
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
  String profilePicture;
  bool emailVerified;
  String subscriptionType;
  int searchRemaining;
  String role;
  bool isActive;
  bool isDeleted;
  String jwtToken;
  String passwordResetToken;
  String sId;
  String name;
  String email;
  String password;
  Null otp;
  String updatedAt;
  String createdAt;
  int iV;

  Result(
      {this.profilePicture,
        this.emailVerified,
        this.subscriptionType,
        this.searchRemaining,
        this.role,
        this.isActive,
        this.isDeleted,
        this.jwtToken,
        this.passwordResetToken,
        this.sId,
        this.name,
        this.email,
        this.password,
        this.otp,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Result.fromJson(Map<String, dynamic> json) {
    profilePicture = json['profile_picture'];
    emailVerified = json['email_verified'];
    subscriptionType = json['subscription_type'];
    searchRemaining = json['search_remaining'];
    role = json['role'];
    isActive = json['is_active'];
    isDeleted = json['is_deleted'];
    jwtToken = json['jwt_token'];
    passwordResetToken = json['password_reset_token'];
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_picture'] = this.profilePicture;
    data['email_verified'] = this.emailVerified;
    data['subscription_type'] = this.subscriptionType;
    data['search_remaining'] = this.searchRemaining;
    data['role'] = this.role;
    data['is_active'] = this.isActive;
    data['is_deleted'] = this.isDeleted;
    data['jwt_token'] = this.jwtToken;
    data['password_reset_token'] = this.passwordResetToken;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
