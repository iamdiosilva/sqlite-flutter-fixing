class User {
  int? id;
  String name;
  String age;

  User({this.id, required this.name, required this.age});

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'age': age,
      };

  static User fromJson(Map<String, Object?> json) => User(
        id: json['id'] as int,
        name: json['name'] as String,
        age: json['age'] as String,
      );
}
