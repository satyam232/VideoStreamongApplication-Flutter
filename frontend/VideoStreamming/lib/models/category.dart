class Categories {
  final String title;
  final String description;
  final String id;
  final String updatedOn;
  final int v;

  Categories({
    required this.title,
    required this.description,
    required this.id,
    required this.updatedOn,
    required this.v,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      title: json['title'],
      description: json['description'],
      id: json['_id'],
      updatedOn: json['updatedOn'],
      v: json['__v'],
    );
  }
}
