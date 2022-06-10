class BrandMaster {
  int _success;
  int _total;
  List<BrandDetails> _result;

  BrandMaster({int success, int total, List<BrandDetails> result}) {
    this._success = success;
    this._total = total;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  int get total => _total;
  set total(int total) => _total = total;
  List<BrandDetails> get result => _result;
  set result(List<BrandDetails> result) => _result = result;

  BrandMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _total = json['total'];
    if (json['result'] != null) {
      _result = new List<BrandDetails>();
      json['result'].forEach((v) {
        _result.add(new BrandDetails.fromJson(v));
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

class BrandDetails {

  String _manufacturerId;
  String _manufacturerName;
  String _image;

  BrandDetails({String manufacturerId, String manufacturerName, String image}) {
    this._manufacturerId = manufacturerId;
    this._manufacturerName = manufacturerName;
    this._image = image;
  }

  String get manufacturerId => _manufacturerId;
  set manufacturerId(String manufacturerId) => _manufacturerId = manufacturerId;
  String get manufacturerName => _manufacturerName;
  set manufacturerName(String manufacturerName) =>
      _manufacturerName = manufacturerName;
  String get image => _image;
  set image(String image) => _image = image;

  BrandDetails.fromJson(Map<String, dynamic> json) {
    _manufacturerId = json['manufacturerId'];
    _manufacturerName = json['manufacturerName'];
    _image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manufacturerId'] = this._manufacturerId;
    data['manufacturerName'] = this._manufacturerName;
    data['image'] = this._image;
    return data;
  }
}
