class FavoritesMaster {
  int _success;
  String _total;
  List<FavoritesDetails> _result;

  FavoritesMaster({int success, String total, List<FavoritesDetails> result}) {
    this._success = success;
    this._total = total;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get total => _total;
  set total(String total) => _total = total;
  List<FavoritesDetails> get result => _result;
  set result(List<FavoritesDetails> result) => _result = result;

  FavoritesMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _total = json['total'];
    if (json['result'] != null) {
      _result = new List<FavoritesDetails>();
      json['result'].forEach((v) {
        _result.add(new FavoritesDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['total'] = this._total;
    if (this._result != null) {
      data['result'] = this._result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoritesDetails {
  String _productId;
  String _name;
  String _currencyCode;
  String _price;
  String _thumbImage;
  String _isOptions;

  FavoritesDetails(
      {String productId,
        String name,
        String currencyCode,
        String price,
        String thumbImage,
        String isOptions}) {
    this._productId = productId;
    this._name = name;
    this._currencyCode = currencyCode;
    this._price = price;
    this._thumbImage = thumbImage;
    this._isOptions = isOptions;
  }

  String get productId => _productId;
  set productId(String productId) => _productId = productId;
  String get name => _name;
  set name(String name) => _name = name;
  String get currencyCode => _currencyCode;
  set currencyCode(String currencyCode) => _currencyCode = currencyCode;
  String get price => _price;
  set price(String price) => _price = price;
  String get thumbImage => _thumbImage;
  set thumbImage(String thumbImage) => _thumbImage = thumbImage;
  String get isOptions => _isOptions;
  set isOptions(String isOptions) => _isOptions = isOptions;

  FavoritesDetails.fromJson(Map<String, dynamic> json) {
    _productId = json['productId'];
    _name = json['name'];
    _currencyCode = json['currencyCode'];
    _price = json['price'];
    _thumbImage = json['thumbImage'];
    _isOptions = json['isOptions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this._productId;
    data['name'] = this._name;
    data['currencyCode'] = this._currencyCode;
    data['price'] = this._price;
    data['thumbImage'] = this._thumbImage;
    data['isOptions'] = this._isOptions;
    return data;
  }
}
