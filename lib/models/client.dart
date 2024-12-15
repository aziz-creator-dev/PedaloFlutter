class Client {
  final int id;
  final String? name; // Nullable field
  final String? email; // Nullable field
  final String tel;

  // Constructor
  Client({
    required this.id,
    this.name, // Nullable field
    this.email, // Nullable field
    required this.tel,
  });

  // Factory constructor to create a Client instance from JSON
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'], // Nullable
      email: json['email'], // Nullable
      tel: json['tel'],
    );
  }

  // Method to convert Client instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name, // Nullable
      'email': email, // Nullable
      'tel': tel,
    };
  }
}
