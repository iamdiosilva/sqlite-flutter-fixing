class Adress {
  int? id;
  String? street;
  String? neighborhood;
  String? state;

  Adress({
    this.id,
    required this.street,
    required this.neighborhood,
    required this.state,
  });

  Map<String, Object?> toJson() => {
        'id': id,
        'street': street,
        'neighborhood': neighborhood,
        'state': state,
      };

  static Adress fromJson(Map<String, Object?> json) => Adress(
        id: json['id'] as int,
        street: json['street'] as String,
        neighborhood: json['neighborhood'] as String,
        state: json['state'] as String,
      );
}
