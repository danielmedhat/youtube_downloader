class SearchModel {
  List<Items> items = [];
  SearchModel.fromJson(Map<String, dynamic> json) {
    json['items'].forEach((element) {
      items.add(Items.fromJson(element));
    });
  }
}

class Items {
  Id? id;
  Snippet? snippet;
  Items.fromJson(Map<String, dynamic> json) {
    id = Id.fromJson(json['id']);
    snippet = Snippet.fromJson(json['snippet']);
  }
}

class Id {
  String? videoId;
  Id.fromJson(Map<String, dynamic> json) {
    videoId = json['videoId'];
  }
}

class Snippet {
  String? publishedAt;
  String? title;
  String? channelTitle;
  Thumbnails? thumbnails;

  Snippet.fromJson(Map<String, dynamic> json) {
    thumbnails = Thumbnails.fromJson(json['thumbnails']);
    title = json['title'];
    channelTitle = json['channelTitle'];
    publishedAt = json['publishedAt'];
  }
}

class Thumbnails {
  Medium? medium;
  Thumbnails.fromJson(Map<String, dynamic> json) {
    medium = Medium.fromJson(json['medium']);
  }
}

class Medium {
  String? url;
  Medium.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }
}
