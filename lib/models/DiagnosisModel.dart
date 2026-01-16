class Diagnosis {
  final String id;
  final String name;

  Diagnosis({
    required this.id,
    required this.name,
  });

  factory Diagnosis.fromMap(Map<String, dynamic> map) {
    return Diagnosis(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
