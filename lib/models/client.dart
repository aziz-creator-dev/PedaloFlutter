class Client {
  final int id;
  final String? name;
  final String? email;
  final String tel;

  Client({
    required this.id,
    this.name,
    this.email,
    required this.tel,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] ?? 0,  
      name: json['name'],    
      email: json['email'],  
      tel: json['tel'] ?? '', 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'tel': tel,
    };
  }
}
