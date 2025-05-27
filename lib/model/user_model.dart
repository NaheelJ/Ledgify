class UserModel {
  final String? id; // Firestore document ID
  final String email;
  final String password;
  final String role;

  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.role,
  });

  // Convert UserModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'EMAIL': email,
      'PASSWORD': password, 
      'ROLE': role,
    };
  }

  // Create UserModel from Firestore document
  factory UserModel.from(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: data['ID'],
      email: data['EMAIL'] ?? '',
      password: data['PASSWORD'] ?? '',
      role: data['ROLE'] ?? '',
    );
  }
}
