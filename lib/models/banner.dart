class Banners {
  int _success;
  List<BannerDetails> _result;

  Banners({int success, List<BannerDetails> result}) {
    this._success = success;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  List<BannerDetails> get result => _result;
  set result(List<BannerDetails> result) => _result = result;

  Banners.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    if (json['result'] != null) {
      _result = new List<BannerDetails>();
      json['result'].forEach((v) {
        _result.add(new BannerDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    if (this._result != null) {
      data['result'] = this._result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerDetails {
  String _title;
  String _image;
  String _productId;

  BannerDetails({String title, String image, String productId}) {
    this._title = title;
    this._image = image;
    this._productId = productId;
  }

  String get title => _title;
  set title(String title) => _title = title;
  String get image => _image;
  set image(String image) => _image = image;
  String get productId => _productId;
  set productId(String productId) => _productId = productId;

  BannerDetails.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _image = json['image'];
    _productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    data['image'] = this._image;
    data['productId'] = this._productId;
    return data;
  }
}
