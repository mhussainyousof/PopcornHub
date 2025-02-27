class RequestTokenModel {
  final bool success;
  final String requestToken;
  final String expiresAt;
  RequestTokenModel({
    required this.success,
    required this.requestToken,
    required this.expiresAt,
  });

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) {
    return RequestTokenModel(
        success: json['success'],
        requestToken: json['request_token'],
        expiresAt: json['expires_at']);
  }

  Map<String, dynamic> toJson() => {
    'request_token' : requestToken
  };
}