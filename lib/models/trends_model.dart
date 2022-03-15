class TrendsModel {
  List<Items> items = [];
  TrendsModel.fromJson(Map<String, dynamic> json) {
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
  Standard? standard;
  Thumbnails.fromJson(Map<String, dynamic> json) {
    standard = Standard.fromJson(json['medium']);
  }
}

class Standard {
  String? url;
  Standard.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }
}
