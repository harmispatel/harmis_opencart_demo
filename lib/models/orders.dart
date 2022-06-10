class OrderDetailsMaster {
  int _success;
  int _total;
  List<OrderDetails> _result;

  OrderDetailsMaster({int success, int total, List<OrderDetails> result}) {
    this._success = success;
    this._total = total;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  int get total => _total;
  set total(int total) => _total = total;
  List<OrderDetails> get result => _result;
  set result(List<OrderDetails> result) => _result = result;

  OrderDetailsMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _total = json['total'];
    if (json['result'] != null) {
      _result = new List<OrderDetails>();
      json['result'].forEach((v) {
        _result.add(new OrderDetails.fromJson(v));
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

class OrderDetails {

  String _orderNo;
  String _totalPrice;
  String _invoice;
  String _quantity;
  String _statusId;
  String _statusName;
  String _statusText;
  String _statusColor;
  String _statusDate;
  String _orderDate;

  OrderDetails(
      {String orderNo,
        String totalPrice,
        String invoice,
        String quantity,
        String statusId,
        String statusName,
        String statusText,
        String statusColor,
        String statusDate,
        String orderDate}) {
    this._orderNo = orderNo;
    this._totalPrice = totalPrice;
    this._invoice = invoice;
    this._quantity = quantity;
    this._statusId = statusId;
    this._statusName = statusName;
    this._statusText = statusText;
    this._statusColor = statusColor;
    this._statusDate = statusDate;
    this._orderDate = orderDate;
  }

  String get orderNo => _orderNo;
  set orderNo(String orderNo) => _orderNo = orderNo;
  String get totalPrice => _totalPrice;
  set totalPrice(String totalPrice) => _totalPrice = totalPrice;
  String get invoice => _invoice;
  set invoice(String invoice) => _invoice = invoice;
  String get quantity => _quantity;
  set quantity(String quantity) => _quantity = quantity;
  String get statusId => _statusId;
  set statusId(String statusId) => _statusId = statusId;
  String get statusName => _statusName;
  set statusName(String statusName) => _statusName = statusName;
  String get statusText => _statusText;
  set statusText(String statusText) => _statusText = statusText;
  String get statusColor => _statusColor;
  set statusColor(String statusColor) => _statusColor = statusColor;
  String get statusDate => _statusDate;
  set statusDate(String statusDate) => _statusDate = statusDate;
  String get orderDate => _orderDate;
  set orderDate(String orderDate) => _orderDate = orderDate;

  OrderDetails.fromJson(Map<String, dynamic> json) {
    _orderNo = json['orderNo'];
    _totalPrice = json['totalPrice'];
    _invoice = json['invoice'];
    _quantity = json['quantity'];
    _statusId = json['statusId'];
    _statusName = json['statusName'];
    _statusText = json['statusText'];
    _statusColor = json['statusColor'];
    _statusDate = json['statusDate'];
    _orderDate = json['orderDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNo'] = this._orderNo;
    data['totalPrice'] = this._totalPrice;
    data['invoice'] = this._invoice;
    data['quantity'] = this._quantity;
    data['statusId'] = this._statusId;
    data['statusName'] = this._statusName;
    data['statusText'] = this._statusText;
    data['statusColor'] = this._statusColor;
    data['statusDate'] = this._statusDate;
    data['orderDate'] = this._orderDate;
    return data;
  }
}
