class BuyModel {
  final int? id;
  final int clientId;
  final double valor;
  final String description;

  BuyModel({
    this.id,
    required this.clientId,
    required this.valor,
    required this.description,
  });

  factory BuyModel.fromJson(Map<String, dynamic> json) {
    return BuyModel(
      id: json['id'],
      clientId: json['client_id'],
      valor: json['valor'],
      description: json['description'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client_id': clientId,
      'valor': valor,
      'description': description,
    };
  }
}
