class SearchMaster {
  int _success;
  String _total;
  List<SearchDetails> _result;

  SearchMaster({int success, String total, List<SearchDetails> result}) {
    this._success = success;
    this._total = total;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get total => _total;
  set total(String total) => _total = total;
  List<SearchDetails> get result => _result;
  set result(List<SearchDetails> result) => _result = result;

  SearchMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _total = json['total'];
    if (json['result'] != null) {
      _result = new List<SearchDetails>();
      json['result'].forEach((v) {
        _result.add(new SearchDetails.fromJson(v));
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

class SearchDetails {
  String _productId;
  String _name;
  List<SearchCategory> _category;
  String _currencyCode;
  String _price;
  String _specialPrice;
  String _minQuantity;
  String _quantity;
  String _minQuantityDesc;
  String _inStock;
  String _thumbImage;
  String _isOptions;

  SearchDetails(
      {String productId,
        String name,
        List<SearchCategory> category,
        String currencyCode,
        String price,
        String specialPrice,
        String minQuantity,
        String quantity,
        String minQuantityDesc,
        String inStock,
        String thumbImage,
        String isOptions}) {
    this._productId = productId;
    this._name = name;
    this._category = category;
    this._currencyCode = currencyCode;
    this._price = price;
    this._specialPrice = specialPrice;
    this._minQuantity = minQuantity;
    this._quantity = quantity;
    this._minQuantityDesc = minQuantityDesc;
    this._inStock = inStock;
    this._thumbImage = thumbImage;
    this._isOptions = isOptions;
  }

  String get productId => _productId;
  set productId(String productId) => _productId = productId;
  String get name => _name;
  set name(String name) => _name = name;
  List<SearchCategory> get category => _category;
  set category(List<SearchCategory> category) => _category = category;
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
  String get inStock => _inStock;
  set inStock(String inStock) => _inStock = inStock;
  String get thumbImage => _thumbImage;
  set thumbImage(String thumbImage) => _thumbImage = thumbImage;
  String get isOptions => _isOptions;
  set isOptions(String isOptions) => _isOptions = isOptions;

  SearchDetails.fromJson(Map<String, dynamic> json) {
    _productId = json['productId'];
    _name = json['name'];
    if (json['category'] != null) {
      _category = new List<SearchCategory>();
      json['category'].forEach((v) {
        _category.add(new SearchCategory.fromJson(v));
      });
    }
    _currencyCode = json['currencyCode'];
    _price = json['price'];
    _specialPrice = json['specialPrice'];
    _minQuantity = json['minQuantity'];
    _quantity = json['quantity'];
    _minQuantityDesc = json['minQuantityDesc'];
    _inStock = json['inStock'];
    _thumbImage = json['thumbImage'];
    _isOptions = json['isOptions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this._productId;
    data['name'] = this._name;
    if (this._category != null) {
      data['category'] = this._category.map((v) => v.toJson()).toList();
    }
    data['currencyCode'] = this._currencyCode;
    data['price'] = this._price;
    data['specialPrice'] = this._specialPrice;
    data['minQuantity'] = this._minQuantity;
    data['quantity'] = this._quantity;
    data['minQuantityDesc'] = this._minQuantityDesc;
    data['inStock'] = this._inStock;
    data['thumbImage'] = this._thumbImage;
    data['isOptions'] = this._isOptions;
    return data;
  }
}

class SearchCategory {
  String _id;
  String _title;

  SearchCategory({String id, String title}) {
    this._id = id;
    this._title = title;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;

  SearchCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    return data;
  }
}
