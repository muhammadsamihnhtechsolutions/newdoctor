class Surgery {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Surgery({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Surgery.fromMap(Map<String, dynamic> json) {
    return Surgery(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
