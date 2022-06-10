class ProductMaster {
  int _success;
  int _total;
  List<ProductSingle> _result;

  ProductMaster({int success, int total, List<ProductSingle> result}) {
    this._success = success;
    this._total = total;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  int get total => _total;
  set total(int total) => _total = total;
  List<ProductSingle> get result => _result;
  set result(List<ProductSingle> result) => _result = result;

  ProductMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    if (json['total'] != null) {
      _total = json['total'] is int ? json['total'] : int.parse(json['total']);
    }
    if (json['result'] != null) {
      _result = new List<ProductSingle>();
      json['result'].forEach((v) {
        _result.add(new ProductSingle.fromJson(v));
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

class ProductSingle {
  String _manufacturer;
  String _productId;
  String _name;
  String _model;
  String _currencyCode;
  String _price;
  String _specialPrice;
  String _minQuantity;
  String _quantity;
  String _minQuantityDesc;
  String _isfavourite;
  String _thumbImage;
  String _isOptions;

  ProductSingle(
      {String manufacturer,
        String productId,
        String name,
        String model,
        String currencyCode,
        String price,
        String specialPrice,
        String minQuantity,
        String quantity,
        String minQuantityDesc,
        String isfavourite,
        String thumbImage,
        String isOptions}) {
    this._manufacturer = manufacturer;
    this._productId = productId;
    this._name = name;
    this._model = model;
    this._currencyCode = currencyCode;
    this._price = price;
    this._specialPrice = specialPrice;
    this._minQuantity = minQuantity;
    this._quantity = quantity;
    this._minQuantityDesc = minQuantityDesc;
    this._isfavourite = isfavourite;
    this._thumbImage = thumbImage;
    this._isOptions = isOptions;
  }

  String get manufacturer => _manufacturer;
  set manufacturer(String manufacturer) => _manufacturer = manufacturer;
  String get productId => _productId;
  set productId(String productId) => _productId = productId;
  String get name => _name;
  set name(String name) => _name = name;
  String get model => _model;
  set model(String model) => _model = model;
  String get currencyCode => _currencyCode;
  set currencyCode(String currencyCode) => _currencyCode = currencyCode;
  String get price => _price;
  set price(String price) => _price = price;
  String get specialPrice => _specialPrice;
  set specialPrice(String specialPrice) => _specialPrice = specialPrice;
  String get minQuantity => _minQuantity;
  set minQuantity(String minQuantity) => _minQuantity = minQuantity;
  String get quantity => _quantity;
  set quantity(String quantity) => _quantity = quantity;
  String get minQuantityDesc => _minQuantityDesc;
  set minQuantityDesc(String minQuantityDesc) =>
      _minQuantityDesc = minQuantityDesc;
  String get isfavourite => _isfavourite;
  set isfavourite(String isfavourite) => _isfavourite = isfavourite;
  String get thumbImage => _thumbImage;
  set thumbImage(String thumbImage) => _thumbImage = thumbImage;
  String get isOptions => _isOptions;
  set isOptions(String isOptions) => _isOptions = isOptions;

  ProductSingle.fromJson(Map<String, dynamic> json) {
    _manufacturer = json['manufacturer'];
    _productId = json['productId'];
    _name = json['name'];
    _model = json['model'];
    _currencyCode = json['currencyCode'];
    _price = json['price'];
    _specialPrice = json['specialPrice'];
    _minQuantity = json['minQuantity'];
    _quantity = json['quantity'];
    _minQuantityDesc = json['minQuantityDesc'];
    _isfavourite = json['isfavourite'];
    _thumbImage = json['thumbImage'];
    _isOptions = json['isOptions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manufacturer'] = this._manufacturer;
    data['productId'] = this._productId;
    data['name'] = this._name;
    data['model'] = this._model;
    data['currencyCode'] = this._currencyCode;
    data['price'] = this._price;
    data['specialPrice'] = this._specialPrice;
    data['minQuantity'] = this._minQuantity;
    data['quantity'] = this._quantity;
    data['minQuantityDesc'] = this._minQuantityDesc;
    data['isfavourite'] = this._isfavourite;
    data['thumbImage'] = this._thumbImage;
    data['isOptions'] = this._isOptions;
    return data;
  }
}