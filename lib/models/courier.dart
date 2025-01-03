class Courier {
  final int id;
  final String? name;
  final String? email;
  final String? tel;
  final String? cin;
  final String? licence;
  final String? type;

  Courier({
    required this.id,
    this.name,
    this.email,
    this.tel,
    this.cin,
    this.licence,
    this.type,
  });

  factory Courier.fromJson(Map<String, dynamic> json) {
    return Courier(
      id: json['id'] ?? 0,
      name: json['name'],
      email: json['email'],
      tel: json['tel'] ?? '',
      cin: json['cin'],
      licence: json['licence'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'tel': tel,
      'cin': cin,
      'licence': licence,
      'type': type,
    };
  }
}
