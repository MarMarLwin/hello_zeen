class AuthModel {
  AuthModel({
    String? token,
  }) {
    _token = token;
  }

  AuthModel.fromJson(dynamic json) {
    _token = json['token'];
  }
  String? _token;

  AuthModel copyWith({
    String? token,
  }) =>
      AuthModel(
        token: token ?? _token,
      );
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;

    return map;
  }
}
