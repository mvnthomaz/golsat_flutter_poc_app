class ResultImage {
  Data data;
  bool success;
  int status;

  ResultImage({this.data, this.success, this.status});

  ResultImage.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String id;
  Null title;
  Null description;
  int datetime;
  String type;
  bool animated;
  int width;
  int height;
  int size;
  int views;
  int bandwidth;
  Null vote;
  bool favorite;
  Null nsfw;
  Null section;
  Null accountUrl;
  int accountId;
  bool isAd;
  bool inMostViral;
  bool hasSound;
  List<String> tags;
  int adType;
  String adUrl;
  String edited;
  bool inGallery;
  String deletehash;
  String name;
  String link;

  Data(
      {this.id,
        this.title,
        this.description,
        this.datetime,
        this.type,
        this.animated,
        this.width,
        this.height,
        this.size,
        this.views,
        this.bandwidth,
        this.vote,
        this.favorite,
        this.nsfw,
        this.section,
        this.accountUrl,
        this.accountId,
        this.isAd,
        this.inMostViral,
        this.hasSound,
        this.tags,
        this.adType,
        this.adUrl,
        this.edited,
        this.inGallery,
        this.deletehash,
        this.name,
        this.link});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    datetime = json['datetime'];
    type = json['type'];
    animated = json['animated'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
    views = json['views'];
    bandwidth = json['bandwidth'];
    vote = json['vote'];
    favorite = json['favorite'];
    nsfw = json['nsfw'];
    section = json['section'];
    accountUrl = json['account_url'];
    accountId = json['account_id'];
    isAd = json['is_ad'];
    inMostViral = json['in_most_viral'];
    hasSound = json['has_sound'];
    json['tags'] = null;
    adType = json['ad_type'];
    adUrl = json['ad_url'];
    edited = json['edited'];
    inGallery = json['in_gallery'];
    deletehash = json['deletehash'];
    name = json['name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['datetime'] = this.datetime;
    data['type'] = this.type;
    data['animated'] = this.animated;
    data['width'] = this.width;
    data['height'] = this.height;
    data['size'] = this.size;
    data['views'] = this.views;
    data['bandwidth'] = this.bandwidth;
    data['vote'] = this.vote;
    data['favorite'] = this.favorite;
    data['nsfw'] = this.nsfw;
    data['section'] = this.section;
    data['account_url'] = this.accountUrl;
    data['account_id'] = this.accountId;
    data['is_ad'] = this.isAd;
    data['in_most_viral'] = this.inMostViral;
    data['has_sound'] = this.hasSound;
    data['tags'] = null;
    data['ad_type'] = this.adType;
    data['ad_url'] = this.adUrl;
    data['edited'] = this.edited;
    data['in_gallery'] = this.inGallery;
    data['deletehash'] = this.deletehash;
    data['name'] = this.name;
    data['link'] = this.link;
    return data;
  }
}
