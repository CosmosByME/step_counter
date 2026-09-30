class User {
  int age;
  String gender;
  double heightCm;
  double weightKg;

  User({required this.age, required this.heightCm, required this.weightKg, required this.gender});

  User.fromJson(Map<String, dynamic> json)
      : age = json['age'],
        heightCm = json['heightCm'],
        weightKg = json['weightKg'],
        gender = json['gender'];


  Map<String, dynamic> toJson() => {
        'age': age,
        'heightCm': heightCm,
        'weightKg': weightKg,
        'gender': gender,
      };

  User copyWith({int? age, double? heightCm, double? weightKg, String? gender}) {
    return User(
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      gender: gender ?? this.gender,
    );
  }
}