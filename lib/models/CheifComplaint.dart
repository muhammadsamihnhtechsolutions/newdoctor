class ChiefComplaint {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChiefComplaint({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChiefComplaint.fromMap(Map<String, dynamic> json) {
    return ChiefComplaint(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
