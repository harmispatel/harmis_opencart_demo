class DeleteAddressMaster {
  int _success;
  String _message;

  DeleteAddressMaster({int success, String message}) {
    this._success = success;
    this._message = message;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;

  DeleteAddressMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    return data;
  }
}