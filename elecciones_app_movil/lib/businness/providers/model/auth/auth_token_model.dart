class AuthTokenModel {
  String basicToken;

  AuthTokenModel({required this.basicToken});

  AuthTokenModel copyWith({String? basicToken}) {
    return AuthTokenModel(basicToken: basicToken ?? this.basicToken);
  }
}