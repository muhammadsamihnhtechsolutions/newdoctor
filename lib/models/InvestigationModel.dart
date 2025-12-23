class Investigation {
  final String id;
  final String name;

  Investigation({
    required this.id,
    required this.name,
  });

  factory Investigation.fromMap(Map<String, dynamic> json) {
    return Investigation(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class InvestigationApiResponse {
  final List<Investigation> docs;

  InvestigationApiResponse({required this.docs});

  factory InvestigationApiResponse.fromMap(Map<String, dynamic> json) {
    final data = json['data'];
    final list = data?['docs'] as List<dynamic>? ?? [];

    return InvestigationApiResponse(
      docs: list.map((e) => Investigation.fromMap(e)).toList(),
    );
  }
}
