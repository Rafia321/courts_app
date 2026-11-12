class Court {
  final int id;
  final String name;
  final int pricePerHour;
  final bool isIndoor;

  Court({
    required this.id,
    required this.name,
    required this.pricePerHour,
    required this.isIndoor,
  });

  factory Court.fromJson(Map<String, dynamic> json) {
    return Court(
      id: json['id'] as int,
    name: json['title'] as String,
      pricePerHour: (json['id'] as int) * 20, // Example logic for pricePerHour
      isIndoor: (json['id'] as int) % 2 == 0,
    );
  }
}

