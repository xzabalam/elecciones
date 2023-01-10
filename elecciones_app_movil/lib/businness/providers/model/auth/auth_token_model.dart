class AuthTokenModel {
  String basicToken;
  String? error;

  AuthTokenModel({required this.basicToken, this.error});

  AuthTokenModel copyWith({String? basicToken, String? error}) {
    return AuthTokenModel(
        basicToken: basicToken ?? this.basicToken, error: error ?? this.error);
  }
}
