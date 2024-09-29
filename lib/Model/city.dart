class City {
  String id;
  String name;

  City({
    required this.id,
    required this.name,
  });

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'].toString(),
      name: map['name'] ?? "",
    );
  }
  @override
  bool operator ==(o) => o is City && name == o.name && id == o.id;
}
