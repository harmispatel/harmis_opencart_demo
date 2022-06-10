class CouponMaster {
  int _success;
  String _message;
  CouponDetails _result;

  CouponMaster({int success, String message, CouponDetails result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  CouponDetails get result => _result;
  set result(CouponDetails result) => _result = result;

  CouponMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    _result =
    json['result'] != null ? new CouponDetails.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    if (this._result != null) {
      data['result'] = this._result.toJson();
    }
    return data;
  }
}

class CouponDetails {
  String _couponId;
  String _couponType;
  String _couponCode;
  String _currencyCode;
  String _discountValue;
  String _updatedTotal;

  CouponDetails(
      {String couponId,
        String couponType,
        String couponCode,
        String currencyCode,
        String discountValue,
        String updatedTotal}) {
    this._couponId = couponId;
    this._couponType = couponType;
    this._couponCode = couponCode;
    this._currencyCode = currencyCode;
    this._discountValue = discountValue;
    this._updatedTotal = updatedTotal;
  }

  String get couponId => _couponId;
  set couponId(String couponId) => _couponId = couponId;
  String get couponType => _couponType;
  set couponType(String couponType) => _couponType = couponType;
  String get couponCode => _couponCode;
  set couponCode(String couponCode) => _couponCode = couponCode;
  String get currencyCode => _currencyCode;
  set currencyCode(String currencyCode) => _currencyCode = currencyCode;
  String get discountValue => _discountValue;
  set discountValue(String discountValue) => _discountValue = discountValue;
  String get updatedTotal => _updatedTotal;
  set updatedTotal(String updatedTotal) => _updatedTotal = updatedTotal;

  CouponDetails.fromJson(Map<String, dynamic> json) {
    _couponId = json['couponId'];
    _couponType = json['couponType'];
    _couponCode = json['couponCode'];
    _currencyCode = json['currencyCode'];
    _discountValue = json['discountValue'];
    _updatedTotal = json['updatedTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['couponId'] = this._couponId;
    data['couponType'] = this._couponType;
    data['couponCode'] = this._couponCode;
    data['currencyCode'] = this._currencyCode;
    data['discountValue'] = this._discountValue;
    data['updatedTotal'] = this._updatedTotal;
    return data;
  }
}