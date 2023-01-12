class DataResponseModel {
  bool? status;
  String? message;

  DataResponseModel({this.status, this.message});

  factory DataResponseModel.fromJson(Map<String, dynamic> json) {
    return DataResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
    );
  }
}

class UserModel {
  final String accessToken;
  final String refreshToken;
  final String expiration;
  final double expires;

  UserModel({
    required this.refreshToken,
    required this.accessToken,
    required this.expiration,
    required this.expires,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      refreshToken: json['refreshToken'] as String,
      accessToken: json['accessToken'] as String,
      expiration: json['expiration'] as String,
      expires: json['expires'] as double,
    );
  }
}
