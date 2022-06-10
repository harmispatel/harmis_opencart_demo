class CartMaster {
  int _success;
  String _message;
  String _sessionId;
  String _quantity;
  String _totalItem;
  String _subTotal;
  String _total;
  String _currencyCode;
  String _shippingCharge;
  List<CartDetails> _products;
  int _totalWeight;
  String _discountValue;

  CartMaster(
      {int success,
      String message,
      String sessionId,
      String quantity,
      String totalItem,
      String subTotal,
      String total,
      String currencyCode,
      String shippingCharge,
      List<CartDetails> products,
      int totalWeight,
      String discountValue}) {
    this._success = success;
    this._sessionId = sessionId;
    this._message = message;
    this._quantity = quantity;
    this._totalItem = totalItem;
    this._subTotal = subTotal;
    this._total = total;
    this._currencyCode = currencyCode;
    this._shippingCharge = shippingCharge;
    this._products = products;
    this._totalWeight = totalWeight;
    this._discountValue = discountValue;
  }

  int get success => _success;

  set success(int success) => _success = success;

  String get message => _message;

  set message(String message) => _message = message;

  String get sessionId => _sessionId;

  set sessionId(String sessionId) => _sessionId = sessionId;

  String get quantity => _quantity;

  set quantity(String quantity) => _quantity = quantity;

  String get totalItem => _totalItem;

  set totalItem(String totalItem) => _totalItem = totalItem;

  String get subTotal => _subTotal;

  set subTotal(String subTotal) => _subTotal = subTotal;

  String get total => _total;

  set total(String total) => _total = total;

  String get currencyCode => _currencyCode;

  set currencyCode(String currencyCode) => _currencyCode = currencyCode;

  String get shippingCharge => _shippingCharge;

  set shippingCharge(String shippingCharge) => _shippingCharge = shippingCharge;

  List<CartDetails> get products => _products;

  set products(List<CartDetails> products) => _products = products;

  int get totalWeight => _totalWeight;

  set totalWeight(int totalWeight) => _totalWeight = totalWeight;


  String get discountValue => _discountValue;

  set discountValue(String discountValue) {
    _discountValue = discountValue;
  }

  CartMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'].toString();
    _sessionId = json['sessionId'];
    _quantity = json['quantity'];
    _totalItem = json['totalItem'];
    _subTotal = json['subTotal'];
    _total = json['total'];
    _currencyCode = json['currencyCode'];
    _shippingCharge = json['shippingCharge'];
    if (json['products'] != null) {
      _products = new List<CartDetails>();
      json['products'].forEach((v) {
        _products.add(new CartDetails.fromJson(v));
      });
    }
    _totalWeight = json['TotalWeight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['sessionId'] = this._sessionId;
    data['message'] = this._message;
    data['quantity'] = this._quantity;
    data['totalItem'] = this._totalItem;
    data['subTotal'] = this._subTotal;
    data['total'] = this._total;
    data['currencyCode'] = this._currencyCode;
    data['shippingCharge'] = this._shippingCharge;
    if (this._products != null) {
      data['products'] = this._products.map((v) => v.toJson()).toList();
    }
    data['TotalWeight'] = this._totalWeight;
    return data;
  }
}

class CartDetails {
  String _referenceId;
  String _productId;
  String _category;
  String _name;
  String _quantity;
  String _currencyCode;
  String _rewardPoints;
  String _minQuantity;
  String _model;
  String _minQuantityDesc;
  String _thumbImage;
  String _price;
  String _originalPrice;
  String _total;
  List<Options> _options;

  CartDetails(
      {String referenceId,
      String productId,
      String category,
      String name,
      String quantity,
      String currencyCode,
      String rewardPoints,
      String minQuantity,
      String model,
      String minQuantityDesc,
      String thumbImage,
      String price,
      String originalPrice,
      String total,
      List<Options> options}) {
    this._referenceId = referenceId;
    this._productId = productId;
    this._category = category;
    this._name = name;
    this._quantity = quantity;
    this._currencyCode = currencyCode;
    this._rewardPoints = rewardPoints;
    this._minQuantity = minQuantity;
    this._model = model;
    this._minQuantityDesc = minQuantityDesc;
    this._thumbImage = thumbImage;
    this._price = price;
    this._originalPrice = originalPrice;
    this._total = total;
    this._options = options;
  }

  String get referenceId => _referenceId;

  set referenceId(String referenceId) => _referenceId = referenceId;

  String get productId => _productId;

  set productId(String productId) => _productId = productId;

  String get category => _category;

  set category(String category) => _category = category;

  String get name => _name;

  set name(String name) => _name = name;

  String get quantity => _quantity;

  set quantity(String quantity) => _quantity = quantity;

  String get currencyCode => _currencyCode;

  set currencyCode(String currencyCode) => _currencyCode = currencyCode;

  String get rewardPoints => _rewardPoints;

  set rewardPoints(String rewardPoints) => _rewardPoints = rewardPoints;

  String get minQuantity => _minQuantity;

  set minQuantity(String minQuantity) => _minQuantity = minQuantity;

  String get model => _model;

  set model(String model) => _model = model;

  String get minQuantityDesc => _minQuantityDesc;

  set minQuantityDesc(String minQuantityDesc) =>
      _minQuantityDesc = minQuantityDesc;

  String get thumbImage => _thumbImage;

  set thumbImage(String thumbImage) => _thumbImage = thumbImage;

  String get price => _price;

  set price(String price) => _price = price;

  String get originalPrice => _originalPrice;

  set originalPrice(String originalPrice) => _originalPrice = originalPrice;

  String get total => _total;

  set total(String total) => _total = total;

  List<Options> get options => _options;

  set options(List<Options> options) => _options = options;

  CartDetails.fromJson(Map<String, dynamic> json) {
    _referenceId = json['referenceId'];
    _productId = json['productId'];
    _category = json['category'];
    _name = json['name'];
    _quantity = json['quantity'];
    _currencyCode = json['currencyCode'];
    _rewardPoints = json['rewardPoints'];
    _minQuantity = json['minQuantity'];
    _model = json['model'];
    _minQuantityDesc = json['minQuantityDesc'];
    _thumbImage = json['thumbImage'];
    _price = json['price'];
    _originalPrice = json['originalPrice'];
    _total = json['total'];
    if (json['options'] != null) {
      _options = new List<Options>();
      json['options'].forEach((v) {
        _options.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referenceId'] = this._referenceId;
    data['productId'] = this._productId;
    data['category'] = this._category;
    data['name'] = this._name;
    data['quantity'] = this._quantity;
    data['currencyCode'] = this._currencyCode;
    data['rewardPoints'] = this._rewardPoints;
    data['minQuantity'] = this._minQuantity;
    data['model'] = this._model;
    data['minQuantityDesc'] = this._minQuantityDesc;
    data['thumbImage'] = this._thumbImage;
    data['price'] = this._price;
    data['originalPrice'] = this._originalPrice;
    data['total'] = this._total;
    if (this._options != null) {
      data['options'] = this._options.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  String _productOptionId;
  String _isMandatory;
  String _type;
  String _title;
  List<Items> _items;

  Options(
      {String productOptionId,
      String isMandatory,
      String type,
      String title,
      List<Items> items}) {
    this._productOptionId = productOptionId;
    this._isMandatory = isMandatory;
    this._type = type;
    this._title = title;
    this._items = items;
  }

  String get productOptionId => _productOptionId;

  set productOptionId(String productOptionId) =>
      _productOptionId = productOptionId;

  String get isMandatory => _isMandatory;

  set isMandatory(String isMandatory) => _isMandatory = isMandatory;

  String get type => _type;

  set type(String type) => _type = type;

  String get title => _title;

  set title(String title) => _title = title;

  List<Items> get items => _items;

  set items(List<Items> items) => _items = items;

  Options.fromJson(Map<String, dynamic> json) {
    _productOptionId = json['productOptionId'];
    _isMandatory = json['isMandatory'];
    _type = json['type'];
    _title = json['title'];
    if (json['items'] != null) {
      _items = new List<Items>();
      json['items'].forEach((v) {
        _items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productOptionId'] = this._productOptionId;
    data['isMandatory'] = this._isMandatory;
    data['type'] = this._type;
    data['title'] = this._title;
    if (this._items != null) {
      data['items'] = this._items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String _optionId;
  String _value;

  Items({String optionId, String value}) {
    this._optionId = optionId;
    this._value = value;
  }

  String get optionId => _optionId;

  set optionId(String optionId) => _optionId = optionId;

  String get value => _value;

  set value(String value) => _value = value;

  Items.fromJson(Map<String, dynamic> json) {
    _optionId = json['optionId'];
    _value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optionId'] = this._optionId;
    data['value'] = this._value;
    return data;
  }
}
