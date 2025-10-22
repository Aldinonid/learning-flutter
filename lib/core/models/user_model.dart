class UserModel {
  final String nama;
  final String email;
  final String profPic;

  UserModel({
    required this.nama,
    required this.email,
    required this.profPic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nama: json['nama'] ?? '',
      email: json['email'] ?? '',
      profPic: json['profile_picture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'email': email,
      'profile_picture': profPic,
    };
  }
}