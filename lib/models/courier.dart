class Courier {
  final int id;
  final String? name;
  final String? email;
  final String? status;
  final String tel;

  // Constructor
  Courier({
    required this.id,
    this.name,
    this.email,
    this.status,
    required this.tel,
  });

  // Factory constructor to create a Courier instance from JSON
  factory Courier.fromJson(Map<String, dynamic> json) {
    return Courier(
      id: json['id'],
      name: json['name'], // nullable
      email: json['email'], // nullable
      status: json['status'], // nullable
      tel: json['tel'],
    );
  }

  // Method to convert Courier instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name, // nullable
      'email': email, // nullable
      'status': status, // nullable
      'tel': tel,
    };
  }
}
