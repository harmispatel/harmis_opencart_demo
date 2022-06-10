class BestSellerMaster {
  int _success;
  List<BestSellerDetails> _result;

  BestSellerMaster({int success, List<BestSellerDetails> result}) {
    this._success = success;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  List<BestSellerDetails> get result => _result;
  set result(List<BestSellerDetails> result) => _result = result;

  BestSellerMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    if (json['result'] != null) {
      _result = new List<BestSellerDetails>();
      json['result'].forEach((v) {
        _result.add(new BestSellerDetails.fromJson(v));
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

class BestSellerDetails {
  String _productId;
  String _name;
  String _price;
  String _thumbImage;
  String _currencyCode;
  String _specialPrice;
  String _discountPercentage;
  String _inStock;
  String _isOptions;

  BestSellerDetails(
      {String productId,
        String name,
        String price,
        String thumbImage,
        String currencyCode,
        String specialPrice,
        String discountPercentage,
        String inStock,
        String isOptions}) {
    this._productId = productId;
    this._name = name;
    this._price = price;
    this._thumbImage = thumbImage;
    this._currencyCode = currencyCode;
    this._specialPrice = specialPrice;
    this._discountPercentage = discountPercentage;
    this._inStock = inStock;
    this._isOptions = isOptions;
  }

  String get productId => _productId;
  set productId(String productId) => _productId = productId;
  String get name => _name;
  set name(String name) => _name = name;
  String get price => _price;
  set price(String price) => _price = price;
  String get thumbImage => _thumbImage;
  set thumbImage(String thumbImage) => _thumbImage = thumbImage;
  String get currencyCode => _currencyCode;
  set currencyCode(String currencyCode) => _currencyCode = currencyCode;
  String get specialPrice => _specialPrice;
  set specialPrice(String specialPrice) => _specialPrice = specialPrice;
  String get discountPercentage => _discountPercentage;
  set discountPercentage(String discountPercentage) =>
      _discountPercentage = discountPercentage;
  String get inStock => _inStock;
  set inStock(String inStock) => _inStock = inStock;
  String get isOptions => _isOptions;
  set isOptions(String isOptions) => _isOptions = isOptions;

  BestSellerDetails.fromJson(Map<String, dynamic> json) {
    _productId = json['productId'];
    _name = json['name'];
    _price = json['price'];
    _thumbImage = json['thumbImage'];
    _currencyCode = json['currencyCode'];
    _specialPrice = json['specialPrice'];
    _discountPercentage = json['discountPercentage'];
    _inStock = json['inStock'];
    _isOptions = json['isOptions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this._productId;
    data['name'] = this._name;
    data['price'] = this._price;
    data['thumbImage'] = this._thumbImage;
    data['currencyCode'] = this._currencyCode;
    data['specialPrice'] = this._specialPrice;
    data['discountPercentage'] = this._discountPercentage;
    data['inStock'] = this._inStock;
    data['isOptions'] = this._isOptions;
    return data;
  }
}
