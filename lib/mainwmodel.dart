class Temp {
  double min;
  double eve;
  Temp({
  required  this.min,
  required  this.eve,
  });
  factory Temp.fromJson(Map<String, dynamic> response) {
    return Temp(min: response['min'], eve: response['eve']);
  }
}
