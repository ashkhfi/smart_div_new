class UserModel {
  String uid;
  String? name;
  String? image;
  String email;
  String? jabatan; // Tambahan field jabatan

  UserModel({
    required this.uid,
    required this.email,
    this.name,
    this.image,
    this.jabatan, // Jabatan di sini bisa null saat register
  });

  // Method untuk membuat UserModel dari data JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      image: json['image'],
      jabatan: json['jabatan'], // Mengambil data jabatan dari JSON
    );
  }

  // Method untuk mengubah UserModel menjadi data JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'image': image,
      'jabatan': jabatan, // Mengubah data jabatan menjadi JSON
    };
  }
}
