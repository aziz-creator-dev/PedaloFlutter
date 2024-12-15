class Order {
  final int id;
  final int clientId;
  final int courierId;
  final String pickupAddress;
  final String deliveryAddress;
  final String status;
  final String date;
  final String type;

  // Constructor
  Order({
    required this.id,
    required this.clientId,
    required this.courierId,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.status,
    required this.date,
    required this.type,
  });

  // Factory constructor to create an Order instance from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      clientId: json['client_id'],
      courierId: json['courier_id'],
      pickupAddress: json['pickup_address'],
      deliveryAddress: json['delivery_address'],
      status: json['status'],
      date: json['date'],
      type: json['type'],
    );
  }

  // Method to convert Order instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': clientId,
      'courier_id': courierId,
      'pickup_address': pickupAddress,
      'delivery_address': deliveryAddress,
      'status': status,
      'date': date,
      'type': type,
    };
  }
}
