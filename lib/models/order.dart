class Order {
  final int? id;
  final int? clientId;
  final int? courierId;
  final String? pickupAddress;
  final String? deliveryAddress;
  final String? status;
  final DateTime? date;
  final String? type;

  Order({
    this.id,
    this.clientId,
    this.courierId,
    this.pickupAddress,
    this.deliveryAddress,
    this.status,
    this.date,
    this.type,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      clientId: json['client_id'],
      courierId: json['courier_id'],
      pickupAddress: json['pickup_address'],
      deliveryAddress: json['delivery_address'],
      status: json['status'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'courier_id': courierId,
      'pickup_address': pickupAddress,
      'delivery_address': deliveryAddress,
      'status': status,
      'date': date?.toIso8601String(),
      'type': type,
    };
  }
}
