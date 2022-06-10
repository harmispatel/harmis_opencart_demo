class OrderHistoryMaster {
  int _success;
  OrderHistoryDetails _result;

  OrderHistoryMaster({int success, OrderHistoryDetails result}) {
    this._success = success;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  OrderHistoryDetails get result => _result;
  set result(OrderHistoryDetails result) => _result = result;

  OrderHistoryMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _result =
    json['result'] != null ? new OrderHistoryDetails.fromJson(json['result']) : null;
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

class OrderHistoryDetails {

  String _shippingCharge;
  String _total;
  String _placeOn;
  String _orderNo;
  String _totalAmount;
  String _reward;
  String _affiliate;
  String _currencyCode;
  String _email;
  String _phone;
  String _shipFirstName;
  String _shipLastName;
  String _shipCompany;
  String _shipAdderss1;
  String _shipAddress2;
  String _shipCity;
  String _shipState;
  String _shipCountry;
  String _shipPostcode;
  String _status;
  String _statusName;
  String _invoice;
  String _paymentMethod;

  List<Products> _products;

  OrderHistoryDetails(
      {String shippingCharge,
        String total,
        String placeOn,
        String orderNo,
        String totalAmount,
        String reward,
        String affiliate,
        String currencyCode,
        String email,
        String phone,
        String shipFirstName,
        String shipLastName,
        String shipCompany,
        String shipAdderss1,
        String shipAddress2,
        String shipCity,
        String shipState,
        String shipCountry,
        String shipPostcode,
        String status,
        String statusName,
        String invoice,
        String paymentMethod,
        List<Products> products}) {
    this._shippingCharge = shippingCharge;
    this._total = total;
    this._placeOn = placeOn;
    this._orderNo = orderNo;
    this._totalAmount = totalAmount;
    this._reward = reward;
    this._affiliate = affiliate;
    this._currencyCode = currencyCode;
    this._email = email;
    this._phone = phone;
    this._shipFirstName = shipFirstName;
    this._shipLastName = shipLastName;
    this._shipCompany = shipCompany;
    this._shipAdderss1 = shipAdderss1;
    this._shipAddress2 = shipAddress2;
    this._shipCity = shipCity;
    this._shipState = shipState;
    this._shipCountry = shipCountry;
    this._shipPostcode = shipPostcode;
    this._status = status;
    this._statusName = statusName;
    this._products = products;
    this._invoice = invoice;
    this._paymentMethod = paymentMethod;
  }

  String get shippingCharge => _shippingCharge;
  set shippingCharge(String shippingCharge) => _shippingCharge = shippingCharge;
  String get total => _total;
  set total(String total) => _total = total;
  String get placeOn => _placeOn;
  set placeOn(String placeOn) => _placeOn = placeOn;
  String get orderNo => _orderNo;
  set orderNo(String orderNo) => _orderNo = orderNo;
  String get totalAmount => _totalAmount;
  set totalAmount(String totalAmount) => _totalAmount = totalAmount;
  String get reward => _reward;
  set reward(String reward) => _reward = reward;
  String get affiliate => _affiliate;
  set affiliate(String affiliate) => _affiliate = affiliate;
  String get currencyCode => _currencyCode;
  set currencyCode(String currencyCode) => _currencyCode = currencyCode;
  String get email => _email;
  set email(String email) => _email = email;
  String get phone => _phone;
  set phone(String phone) => _phone = phone;
  String get shipFirstName => _shipFirstName;
  set shipFirstName(String shipFirstName) => _shipFirstName = shipFirstName;
  String get shipLastName => _shipLastName;
  set shipLastName(String shipLastName) => _shipLastName = shipLastName;
  String get shipCompany => _shipCompany;
  set shipCompany(String shipCompany) => _shipCompany = shipCompany;
  String get shipAdderss1 => _shipAdderss1;
  set shipAdderss1(String shipAdderss1) => _shipAdderss1 = shipAdderss1;
  String get shipAddress2 => _shipAddress2;
  set shipAddress2(String shipAddress2) => _shipAddress2 = shipAddress2;
  String get shipCity => _shipCity;
  set shipCity(String shipCity) => _shipCity = shipCity;
  String get shipState => _shipState;
  set shipState(String shipState) => _shipState = shipState;
  String get shipCountry => _shipCountry;
  set shipCountry(String shipCountry) => _shipCountry = shipCountry;
  String get shipPostcode => _shipPostcode;
  set shipPostcode(String shipPostcode) => _shipPostcode = shipPostcode;
  String get status => _status;
  set status(String status) => _status = status;
  String get statusName => _statusName;
  set statusName(String statusName) => _statusName = statusName;

  String get invoice => _invoice;
  set invoice(String invoice) => _invoice = invoice;

  String get paymentMethod => _paymentMethod;
  set paymentMethod(String paymentMethod) => _paymentMethod = paymentMethod;

  List<Products> get products => _products;
  set products(List<Products> products) => _products = products;

  OrderHistoryDetails.fromJson(Map<String, dynamic> json) {
    _shippingCharge = json['shippingCharge'];
    _total = json['total'];
    _placeOn = json['placeOn'];
    _orderNo = json['orderNo'];
    _totalAmount = json['totalAmount'];
    _reward = json['reward'];
    _invoice = json['invoice'];
    _affiliate = json['affiliate'];
    _currencyCode = json['currencyCode'];
    _email = json['email'];
    _phone = json['phone'];
    _shipFirstName = json['shipFirstName'];
    _shipLastName = json['shipLastName'];
    _shipCompany = json['shipCompany'];
    _shipAdderss1 = json['shipAdderss1'];
    _shipAddress2 = json['shipAddress2'];
    _shipCity = json['shipCity'];
    _shipState = json['shipState'];
    _shipCountry = json['shipCountry'];
    _shipPostcode = json['shipPostcode'];
    _status = json['status'];
    _statusName = json['statusName'];
    _paymentMethod = json['paymentMethod'];
    if (json['products'] != null) {
      _products = new List<Products>();
      json['products'].forEach((v) {
        _products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shippingCharge'] = this._shippingCharge;
    data['total'] = this._total;
    data['placeOn'] = this._placeOn;
    data['orderNo'] = this._orderNo;
    data['totalAmount'] = this._totalAmount;
    data['reward'] = this._reward;
    data['affiliate'] = this._affiliate;
    data['currencyCode'] = this._currencyCode;
    data['email'] = this._email;
    data['phone'] = this._phone;
    data['shipFirstName'] = this._shipFirstName;
    data['shipLastName'] = this._shipLastName;
    data['shipCompany'] = this._shipCompany;
    data['shipAdderss1'] = this._shipAdderss1;
    data['shipAddress2'] = this._shipAddress2;
    data['shipCity'] = this._shipCity;
    data['shipState'] = this._shipState;
    data['shipCountry'] = this._shipCountry;
    data['shipPostcode'] = this._shipPostcode;
    data['invoice'] = this._invoice;
    data['status'] = this._status;
    data['paymentMethod'] = this._paymentMethod;
    data['statusName'] = this._statusName;
    if (this._products != null) {
      data['products'] = this._products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String _name;
  String _quantity;
  String _currencyCode;
  String _total;
  String _thumbImage;

  Products(
      {String name,
        String quantity,
        String currencyCode,
        String total,
        String thumbImage}) {
    this._name = name;
    this._quantity = quantity;
    this._currencyCode = currencyCode;
    this._total = total;
    this._thumbImage = thumbImage;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get quantity => _quantity;
  set quantity(String quantity) => _quantity = quantity;
  String get currencyCode => _currencyCode;
  set currencyCode(String currencyCode) => _currencyCode = currencyCode;
  String get total => _total;
  set total(String total) => _total = total;
  String get thumbImage => _thumbImage;
  set thumbImage(String thumbImage) => _thumbImage = thumbImage;

  Products.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _quantity = json['quantity'];
    _currencyCode = json['currencyCode'];
    _total = json['total'];
    _thumbImage = json['thumbImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['quantity'] = this._quantity;
    data['currencyCode'] = this._currencyCode;
    data['total'] = this._total;
    data['thumbImage'] = this._thumbImage;
    return data;
  }
}
