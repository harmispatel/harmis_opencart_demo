
class CountryMasterM {
  int _success;
  List<CountryDetailsM> _result;

  CountryMasterM({int success, List<CountryDetailsM> result}) {
    this._success = success;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  List<CountryDetailsM> get result => _result;
  set result(List<CountryDetailsM> result) => _result = result;

  CountryMasterM.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    if (json['result'] != null) {
      _result = new List<CountryDetailsM>();
      json['result'].forEach((v) {
        _result.add(new CountryDetailsM.fromJson(v));
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

class CountryDetailsM {
  String _countryId;
  String _countryName;

  CountryDetailsM({String countryId, String countryName}) {
    this._countryId = countryId;
    this._countryName = countryName;
  }

  String get countryId => _countryId;
  set countryId(String countryId) => _countryId = countryId;
  String get countryName => _countryName;
  set countryName(String countryName) => _countryName = countryName;

  CountryDetailsM.fromJson(Map<String, dynamic> json) {
    _countryId = json['countryId'];
    _countryName = json['countryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this._countryId;
    data['countryName'] = this._countryName;
    return data;
  }
}
