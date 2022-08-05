class Adress {
  String? street;
  String? neighborhood;
  String? state;

  Adress({
    required this.street,
    required this.neighborhood,
    required this.state,
  });

  Map<String, Object?> toJson() => {
        'street': street,
        'neighborhood': neighborhood,
        'state': state,
      };

  static Adress fromJson(Map<String, Object?> json) => Adress(
        street: json['street'] as String,
        neighborhood: json['neighborhood'] as String,
        state: json['state'] as String,
      );
}
