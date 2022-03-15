class LinkModel {
  List<Items> items = [];
  LinkModel.fromJson(Map<String, dynamic> json) {
    json['items'].forEach((element) {
      items.add(Items.fromJson(element));
    });
  }
}

class Items {
  String? id;
  Snippet? snippet;
  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    snippet = Snippet.fromJson(json['snippet']);
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
