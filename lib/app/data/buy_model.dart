class BuyModel {
  final int? id;
  final int clientId;
  final double value;
  final String description;

  BuyModel({
    this.id,
    required this.clientId,
    required this.value,
    required this.description,
  });

  factory BuyModel.fromJson(Map<String, dynamic> json) {
    return BuyModel(
      id: json['id'],
      clientId: json['client_id'],
      value: json['value'],
      description: json['description'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client_id': clientId,
      'value': value,
      'description': description,
    };
  }
}
