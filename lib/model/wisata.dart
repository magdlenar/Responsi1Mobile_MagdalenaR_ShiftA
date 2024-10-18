class Wisata {
  int? id;
  String? destination;
  String? location;
  String? attraction;
  Wisata({this.id, this.destination, this.location, this.attraction});
  factory Wisata.fromJson(Map<String, dynamic> obj) {
    return Wisata(
        id: obj['id'],
        destination: obj['destination'],
        location: obj['location'],
        attraction: obj['attraction']);
  }
}
