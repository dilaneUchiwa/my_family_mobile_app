class Tokens {
  String accessToken;
  String refreshToken;

  Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
  @override
  String toString() {
    return "(accessToken : $accessToken,refreshToken: $refreshToken}";
  }

  static Tokens getNotFound(){
    return Tokens(accessToken: "NOTFOUND", refreshToken: "NOTFOUND");
  }
}
