class NotificationMaster {
  int _success;
  int _total;
  String _badgeCount;
  List<NotificationDetails> _result;

  NotificationMaster(
      {int success, int total, String badgeCount, List<NotificationDetails> result}) {
    this._success = success;
    this._total = total;
    this._badgeCount = badgeCount;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  int get total => _total;
  set total(int total) => _total = total;
  String get badgeCount => _badgeCount;
  set badgeCount(String badgeCount) => _badgeCount = badgeCount;
  List<NotificationDetails> get result => _result;
  set result(List<NotificationDetails> result) => _result = result;

  NotificationMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _total = json['total'];
    _badgeCount = json['badgeCount'];
    if (json['result'] != null) {
      _result = new List<NotificationDetails>();
      json['result'].forEach((v) {
        _result.add(new NotificationDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['total'] = this._total;
    data['badgeCount'] = this._badgeCount;
    if (this._result != null) {
      data['result'] = this._result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationDetails {
  String _notificationId;
  String _orderNo;
  String _statusName;
  String _statusId;
  int _readStatus;

  NotificationDetails(
      {String notificationId,
        String orderNo,
        String statusName,
        String statusId,
        int readStatus}) {
    this._notificationId = notificationId;
    this._orderNo = orderNo;
    this._statusName = statusName;
    this._statusId = statusId;
    this._readStatus = readStatus;
  }

  String get notificationId => _notificationId;
  set notificationId(String notificationId) => _notificationId = notificationId;
  String get orderNo => _orderNo;
  set orderNo(String orderNo) => _orderNo = orderNo;
  String get statusName => _statusName;
  set statusName(String statusName) => _statusName = statusName;
  String get statusId => _statusId;
  set statusId(String statusId) => _statusId = statusId;
  int get readStatus => _readStatus;
  set readStatus(int readStatus) => _readStatus = readStatus;

  NotificationDetails.fromJson(Map<String, dynamic> json) {
    _notificationId = json['notificationId'];
    _orderNo = json['orderNo'];
    _statusName = json['statusName'];
    _statusId = json['statusId'];
    _readStatus = json['readStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notificationId'] = this._notificationId;
    data['orderNo'] = this._orderNo;
    data['statusName'] = this._statusName;
    data['statusId'] = this._statusId;
    data['readStatus'] = this._readStatus;
    return data;
  }
}
