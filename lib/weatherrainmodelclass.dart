class Weatherrain {
  String main;
  String description;
  Weatherrain({
    required this.main,
    required this.description,
  });
  factory Weatherrain.fromJson(Map<String, dynamic> rain) {
    return Weatherrain(
        main: rain['main'].toString(),
        description: rain['description'].toString());
  }
}
