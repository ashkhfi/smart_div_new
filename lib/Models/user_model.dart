class UserModel {
  String uid;
  String? name;
  String? image;
  String? telepon; // Tambahan field telepon
  String email;
  String? jabatan; // Tambahan field jabatan
  bool? notif; // Tambahan field notif

  UserModel({
    required this.uid,
    required this.email,
    this.name,
    this.image,
    this.telepon, // Tambahan field telepon di sini
    this.jabatan, // Jabatan di sini bisa null saat register
    this.notif, // Notif di sini bisa null saat register
  });

  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      image: json['image'],
      telepon: json['telepon'], // Mengambil data telepon dari JSON
      jabatan: json['jabatan'], // Mengambil data jabatan dari JSON
      notif: json['notif'], // Mengambil data notif dari JSON
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'image': image,
      'telepon': telepon, // Mengubah data telepon menjadi JSON
      'jabatan': jabatan, // Mengubah data jabatan menjadi JSON
      'notif': notif, // Mengubah data notif menjadi JSON
    };
  }
}
