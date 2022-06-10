class ProductDetailMaster {
  int _success;
  ProductDetail _result;

  ProductDetailMaster({int success, ProductDetail result}) {
    this._success = success;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  ProductDetail get result => _result;
  set result(ProductDetail result) => _result = result;

  ProductDetailMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _result =
    json['result'] != null ? new ProductDetail.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    if (this._result != null) {
      data['result'] = this._result.toJson();
    }
    return data;
  }
}

class ProductDetail {
  String _productId;
  String _name;
  int _isFavourite;
  List<ProductImage> _images;
  String _description;
  String _model;
  String _currencyCode;
  String _orginalPrice;
  String _discountPrice;
  String _minQuantity;
  String _minQuantityDesc;
  String _shareUrl;
  String _inStock;
  ProductCart _cart;
  List<ExtraFields> _extraFields;
  List<ProductOffer> _offers;
  List<Properties> _properties;
  List<ProductOption> _options;
  List<RelatedProducts> _relatedProducts;

  ProductDetail(
      {String productId,
        String name,
        int isFavourite,
        List<ProductImage> images,
        String description,
        String model,
        String currencyCode,
        String orginalPrice,
        String discountPrice,
        String minQuantity,
        String minQuantityDesc,
        String shareUrl,
        String inStock,
        ProductCart cart,
        List<ExtraFields> extraFields,
        List<ProductOffer> offers,
        List<Properties> properties,
        List<ProductOption> options,
        List<RelatedProducts> relatedProducts}) {
    this._productId = productId;
    this._name = name;
    this._isFavourite = isFavourite;
    this._images = images;
    this._description = description;
    this._model = model;
    this._currencyCode = currencyCode;
    this._orginalPrice = orginalPrice;
    this._discountPrice = discountPrice;
    this._minQuantity = minQuantity;
    this._minQuantityDesc = minQuantityDesc;
    this._shareUrl = shareUrl;
    this._inStock = inStock;
    this._cart = cart;
    this._extraFields = extraFields;
    this._offers = offers;
    this._properties = properties;
    this._options = options;
    this._relatedProducts = relatedProducts;
  }

  String get productId => _productId;
  set productId(String productId) => _productId = productId;
  String get name => _name;
  set name(String name) => _name = name;
  int get isFavourite => _isFavourite;
  set isFavourite(int isFavourite) => _isFavourite = isFavourite;
  List<ProductImage> get images => _images;
  set images(List<ProductImage> images) => _images = images;
  String get description => _description;
  set description(String description) => _description = description;
  String get model => _model;
  set model(String model) => _model = model;
  String get currencyCode => _currencyCode;
  set currencyCode(String currencyCode) => _currencyCode = currencyCode;
  String get orginalPrice => _orginalPrice;
  set orginalPrice(String orginalPrice) => _orginalPrice = orginalPrice;
  String get discountPrice => _discountPrice;
  set discountPrice(String discountPrice) => _discountPrice = discountPrice;
  String get minQuantity => _minQuantity;
  set minQuantity(String minQuantity) => _minQuantity = minQuantity;
  String get minQuantityDesc => _minQuantityDesc;
  set minQuantityDesc(String minQuantityDesc) =>
      _minQuantityDesc = minQuantityDesc;
  String get shareUrl => _shareUrl;
  set shareUrl(String shareUrl) => _shareUrl = shareUrl;
  String get inStock => _inStock;
  set inStock(String inStock) => _inStock = inStock;
  ProductCart get cart => _cart;
  set cart(ProductCart cart) => _cart = cart;
  List<ExtraFields> get extraFields => _extraFields;
  set extraFields(List<ExtraFields> extraFields) => _extraFields = extraFields;
  List<ProductOffer> get offers => _offers;
  set offers(List<ProductOffer> offers) => _offers = offers;
  List<Properties> get properties => _properties;
  set properties(List<Properties> properties) => _properties = properties;
  List<ProductOption> get options => _options;
  set options(List<ProductOption> options) => _options = options;
  List<RelatedProducts> get relatedProducts => _relatedProducts;
  set relatedProducts(List<RelatedProducts> relatedProducts) =>
      _relatedProducts = relatedProducts;

  ProductDetail.fromJson(Map<String, dynamic> json) {
    _productId = json['productId'];
    _name = json['name'];
    _isFavourite = json['isFavourite'];
    if (json['images'] != null) {
      _images = new List<ProductImage>();
      json['images'].forEach((v) {
        _images.add(new ProductImage.fromJson(v));
      });
    }
    _description = json['description'];
    _model = json['model'];
    _currencyCode = json['currencyCode'];
    _orginalPrice = json['orginalPrice'];
    _discountPrice = json['discountPrice'];
    _minQuantity = json['minQuantity'];
    _minQuantityDesc = json['minQuantityDesc'];
    _shareUrl = json['shareUrl'];
    _inStock = json['inStock'];
    _cart = json['cart'] != null ? new ProductCart.fromJson(json['cart']) : null;
    if (json['extraFields'] != null) {
      _extraFields = new List<ExtraFields>();
      json['extraFields'].forEach((v) {
        _extraFields.add(new ExtraFields.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      _offers = new List<ProductOffer>();
      json['offers'].forEach((v) {
        _offers.add(new ProductOffer.fromJson(v));
      });
    }
    if (json['properties'] != null) {
      _properties = new List<Properties>();
      json['properties'].forEach((v) {
        _properties.add(new Properties.fromJson(v));
      });
    }
    if (json['options'] != null) {
      _options = new List<ProductOption>();
      json['options'].forEach((v) {
        _options.add(new ProductOption.fromJson(v));
      });
    }
    if (json['relatedProducts'] != null) {
      _relatedProducts = new List<RelatedProducts>();
      json['relatedProducts'].forEach((v) {
        _relatedProducts.add(new RelatedProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this._productId;
    data['name'] = this._name;
    data['isFavourite'] = this._isFavourite;
    if (this._images != null) {
      data['images'] = this._images.map((v) => v.toJson()).toList();
    }
    data['description'] = this._description;
    data['model'] = this._model;
    data['currencyCode'] = this._currencyCode;
    data['orginalPrice'] = this._orginalPrice;
    data['discountPrice'] = this._discountPrice;
    data['minQuantity'] = this._minQuantity;
    data['minQuantityDesc'] = this._minQuantityDesc;
    data['shareUrl'] = this._shareUrl;
    data['inStock'] = this._inStock;
    if (this._cart != null) {
      data['cart'] = this._cart.toJson();
    }
    if (this._extraFields != null) {
      data['extraFields'] = this._extraFields.map((v) => v.toJson()).toList();
    }
    if (this._offers != null) {
      data['offers'] = this._offers.map((v) => v.toJson()).toList();
    }
    if (this._properties != null) {
      data['properties'] = this._properties.map((v) => v.toJson()).toList();
    }
    if (this._options != null) {
      data['options'] = this._options.map((v) => v.toJson()).toList();
    }
    if (this._relatedProducts != null) {
      data['relatedProducts'] =
          this._relatedProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImage {
  String _productImageId;
  String _image;

  ProductImage({String productImageId, String image}) {
    this._productImageId = productImageId;
    this._image = image;
  }

  String get productImageId => _productImageId;
  set productImageId(String productImageId) => _productImageId = productImageId;
  String get image => _image;
  set image(String image) => _image = image;

  ProductImage.fromJson(Map<String, dynamic> json) {
    _productImageId = json['product_image_id'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_image_id'] = this._productImageId;
    data['image'] = this._image;
    return data;
  }
}

class ProductCart {
  String _quantity;
  String _currencyCode;
  String _price;

  ProductCart({String quantity, String currencyCode, String price}) {
    this._quantity = quantity;
    this._currencyCode = currencyCode;
    this._price = price;
  }

  String get quantity => _quantity;
  set quantity(String quantity) => _quantity = quantity;
  String get currencyCode => _currencyCode;
  set currencyCode(String currencyCode) => _currencyCode = currencyCode;
  String get price => _price;
  set price(String price) => _price = price;

  ProductCart.fromJson(Map<String, dynamic> json) {
    _quantity = json['quantity'].toString();
    _currencyCode = json['currencyCode'];
    _price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this._quantity;
    data['currencyCode'] = this._currencyCode;
    data['price'] = this._price;
    return data;
  }
}

class ExtraFields {
  String _placeholder;
  String _value;

  ExtraFields({String placeholder, String value}) {
    this._placeholder = placeholder;
    this._value = value;
  }

  String get placeholder => _placeholder;
  set placeholder(String placeholder) => _placeholder = placeholder;
  String get value => _value;
  set value(String value) => _value = value;

  ExtraFields.fromJson(Map<String, dynamic> json) {
    _placeholder = json['placeholder'];
    _value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placeholder'] = this._placeholder;
    data['value'] = this._value;
    return data;
  }
}

class ProductOffer {
  String _value;

  ProductOffer({String value}) {
    this._value = value;
  }

  String get value => _value;
  set value(String value) => _value = value;

  ProductOffer.fromJson(Map<String, dynamic> json) {
    _value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this._value;
    return data;
  }
}

class Properties {
  String _placeholder;
  String _value;

  Properties({String placeholder, String value}) {
    this._placeholder = placeholder;
    this._value = value;
  }

  String get placeholder => _placeholder;
  set placeholder(String placeholder) => _placeholder = placeholder;
  String get value => _value;
  set value(String value) => _value = value;

  Properties.fromJson(Map<String, dynamic> json) {
    _placeholder = json['placeholder'];
    _value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placeholder'] = this._placeholder;
    data['value'] = this._value;
    return data;
  }
}

class ProductOption {
  String _productOptionId;
  String _isMandatory;
  String _type;
  String _title;
  List<ProductItem> _items;

  ProductOption(
      {String productOptionId,
        String isMandatory,
        String type,
        String title,
        List<ProductItem> items}) {
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
  List<ProductItem> get items => _items;
  set items(List<ProductItem> items) => _items = items;

  ProductOption.fromJson(Map<String, dynamic> json) {
    _productOptionId = json['productOptionId'];
    _isMandatory = json['isMandatory'];
    _type = json['type'];
    _title = json['title'];
    if (json['items'] != null) {
      _items = new List<ProductItem>();
      json['items'].forEach((v) {
        _items.add(new ProductItem.fromJson(v));
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

class ProductItem {
  String _optionId;
  String _value;

  ProductItem({String optionId, String value}) {
    this._optionId = optionId;
    this._value = value;
  }

  String get optionId => _optionId;
  set optionId(String optionId) => _optionId = optionId;
  String get value => _value;
  set value(String value) => _value = value;

  ProductItem.fromJson(Map<String, dynamic> json) {
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

class RelatedProducts {
  String _productId;
  String _name;
  String _discountPrice;
  String _currencyCode;
  String _price;
  String _minQuantity;
  String _minQuantityDesc;
  String _isfavourite;
  String _thumbImage;
  String _shareUrl;

  RelatedProducts(
      {String productId,
        String name,
        String discountPrice,
        String currencyCode,
        String price,
        String minQuantity,
        String minQuantityDesc,
        String isfavourite,
        String thumbImage,
        String shareUrl}) {
    this._productId = productId;
    this._name = name;
    this._discountPrice = discountPrice;
    this._currencyCode = currencyCode;
    this._price = price;
    this._minQuantity = minQuantity;
    this._minQuantityDesc = minQuantityDesc;
    this._isfavourite = isfavourite;
    this._thumbImage = thumbImage;
    this._shareUrl = shareUrl;
  }

  String get productId => _productId;
  set productId(String productId) => _productId = productId;
  String get name => _name;
  set name(String name) => _name = name;
  String get discountPrice => _discountPrice;
  set discountPrice(String discountPrice) => _discountPrice = discountPrice;
  String get currencyCode => _currencyCode;
  set currencyCode(String currencyCode) => _currencyCode = currencyCode;
  String get price => _price;
  set price(String price) => _price = price;
  String get minQuantity => _minQuantity;
  set minQuantity(String minQuantity) => _minQuantity = minQuantity;
  String get minQuantityDesc => _minQuantityDesc;
  set minQuantityDesc(String minQuantityDesc) =>
      _minQuantityDesc = minQuantityDesc;
  String get isfavourite => _isfavourite;
  set isfavourite(String isfavourite) => _isfavourite = isfavourite;
  String get thumbImage => _thumbImage;
  set thumbImage(String thumbImage) => _thumbImage = thumbImage;
  String get shareUrl => _shareUrl;
  set shareUrl(String shareUrl) => _shareUrl = shareUrl;

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    _productId = json['productId'];
    _name = json['name'];
    _discountPrice = json['discountPrice'];
    _currencyCode = json['currencyCode'];
    _price = json['price'];
    _minQuantity = json['minQuantity'];
    _minQuantityDesc = json['minQuantityDesc'];
    _isfavourite = json['isfavourite'];
    _thumbImage = json['thumbImage'];
    _shareUrl = json['shareUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this._productId;
    data['name'] = this._name;
    data['discountPrice'] = this._discountPrice;
    data['currencyCode'] = this._currencyCode;
    data['price'] = this._price;
    data['minQuantity'] = this._minQuantity;
    data['minQuantityDesc'] = this._minQuantityDesc;
    data['isfavourite'] = this._isfavourite;
    data['thumbImage'] = this._thumbImage;
    data['shareUrl'] = this._shareUrl;
    return data;
  }
}