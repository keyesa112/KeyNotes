class User {
  String iduser;
  String user_fullname;
  String user_email;
  String user_nohp;
  String user_password;

  User({
    required this.iduser,
    required this.user_fullname,
    required this.user_email,
    required this.user_nohp,
    required this.user_password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      iduser: json['iduser'] ?? '',
      user_fullname: json['user_fullname'] ?? '',
      user_email: json['user_email'] ?? '',
      user_nohp: json['user_nohp'] ?? '',
      user_password: json['user_password'] ?? '',
    );
  }
}