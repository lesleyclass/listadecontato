class Contact {
  final int? id;
  final String name;
  final String phone;
  final String email;

  Contact({this.id, required this.name, required this.phone, required this.email});

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
    } as Map<String, Object?>;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
    );
  }
}