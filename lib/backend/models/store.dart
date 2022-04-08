class Store {
  String id;
  String name;
  String? imageUrl;
  String website;
  Store({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.website,
  }) : super();
}
