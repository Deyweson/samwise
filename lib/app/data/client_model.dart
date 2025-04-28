class ClientModel {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String address;
  int points;

  ClientModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.points = 0,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      points: json['points'] ?? 0,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'points': points,
    };
  }
}
