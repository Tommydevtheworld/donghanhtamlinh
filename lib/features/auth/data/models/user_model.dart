class UserModel {
  final String id;
  final String? email;
  final String? phoneNumber;
  final String? displayName;
  final String? photoUrl;
  final AuthProvider provider;

  UserModel({
    required this.id,
    this.email,
    this.phoneNumber,
    this.displayName,
    this.photoUrl,
    required this.provider,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      provider: AuthProvider.values.firstWhere(
        (e) => e.toString() == 'AuthProvider.${json['provider']}',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'provider': provider.toString().split('.').last,
    };
  }
}

enum AuthProvider { email, phone, google, apple, zalo }
