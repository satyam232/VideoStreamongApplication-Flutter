class Movie {
  bool? sucess;
  List<Data>? data;

  Movie({this.sucess, this.data});

  Movie.fromJson(Map<String, dynamic> json) {
    sucess = json['sucess'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sucess'] = this.sucess;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? category;
  String? movieurl;
  String? image;
  String? title;
  String? description;
  int? iV;

  Data(
      {this.sId,
      this.category,
      this.movieurl,
      this.image,
      this.title,
      this.description,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    movieurl = json['movieurl'];
    image = json['image'];
    title = json['title'];
    description = json['description'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['movieurl'] = this.movieurl;
    data['image'] = this.image;
    data['title'] = this.title;
    data['description'] = this.description;
    data['__v'] = this.iV;
    return data;
  }
}
