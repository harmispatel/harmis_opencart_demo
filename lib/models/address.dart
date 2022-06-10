class AddressMaster {
  int _success;
  String _message;
  List<AddressDetails> _result;

  AddressMaster({int success, String message, List<AddressDetails> result}) {
    this._success = success;
    this._message = message;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  String get message => _message;
  set message(String message) => _message = message;
  List<AddressDetails> get result => _result;
  set result(List<AddressDetails> result) => _result = result;

  AddressMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = new List<AddressDetails>();
      json['result'].forEach((v) {
        _result.add(new AddressDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    if (this._result != null) {
      data['result'] = this._result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressDetails {
  String _addressId;
  String _userId;
  String _fullAddress;
  double _lat;
  double _long;
  String _companyName;
  String _firstName;
  String _lastName;
  String _add1;
  String _add2;
  String _city;
  String _postalCode;
  String _countryId;
  String _countryName;
  String _stateId;
  String _stateName;
  String _distance;
  GoogleAddress _googleAddress;
  String _phone;
  bool _isSelected = false;

  AddressDetails(
      {String addressId,
        String userId,
        String fullAddress,
        double lat,
        double long,
        String companyName,
        String firstName,
        String lastName,
        String add1,
        String add2,
        String city,
        String postalCode,
        String countryId,
        String countryName,
        String stateId,
        String stateName,
        String distance,
        GoogleAddress googleAddress,
        String phone}) {
    this._addressId = addressId;
    this._userId = userId;
    this._fullAddress = fullAddress;
    this._lat = lat;
    this._long = long;
    this._companyName = companyName;
    this._firstName = firstName;
    this._lastName = lastName;
    this._add1 = add1;
    this._add2 = add2;
    this._city = city;
    this._postalCode = postalCode;
    this._countryId = countryId;
    this._countryName = countryName;
    this._stateId = stateId;
    this._stateName = stateName;
    this._distance = distance;
    this._googleAddress = googleAddress;
    this._phone = phone;
  }

  String get addressId => _addressId;
  set addressId(String addressId) => _addressId = addressId;
  String get userId => _userId;
  set userId(String userId) => _userId = userId;
  String get fullAddress => _fullAddress;
  set fullAddress(String fullAddress) => _fullAddress = fullAddress;
  double get lat => _lat;
  set lat(double lat) => _lat = lat;
  double get long => _long;
  set long(double long) => _long = long;
  String get companyName => _companyName;
  set companyName(String companyName) => _companyName = companyName;
  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;
  String get lastName => _lastName;
  set lastName(String lastName) => _lastName = lastName;
  String get add1 => _add1;
  set add1(String add1) => _add1 = add1;
  String get add2 => _add2;
  set add2(String add2) => _add2 = add2;
  String get city => _city;
  set city(String city) => _city = city;
  String get postalCode => _postalCode;
  set postalCode(String postalCode) => _postalCode = postalCode;
  String get countryId => _countryId;
  set countryId(String countryId) => _countryId = countryId;
  String get countryName => _countryName;
  set countryName(String countryName) => _countryName = countryName;
  String get stateId => _stateId;
  set stateId(String stateId) => _stateId = stateId;
  String get stateName => _stateName;
  set stateName(String stateName) => _stateName = stateName;
  String get distance => _distance;
  set distance(String distance) => _distance = distance;
  GoogleAddress get googleAddress => _googleAddress;
  set googleAddress(GoogleAddress googleAddress) =>
      _googleAddress = googleAddress;
  String get phone => _phone;
  set phone(String phone) => _phone = phone;


  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }

  AddressDetails.fromJson(Map<String, dynamic> json) {
    _addressId = json['addressId'];
    _userId = json['userId'];
    _fullAddress = json['fullAddress'];
    _lat = json['lat'];
    _long = json['long'];
    _companyName = json['companyName'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _add1 = json['add1'];
    _add2 = json['add2'];
    _city = json['city'];
    _postalCode = json['postalCode'];
    _countryId = json['countryId'];
    _countryName = json['countryName'];
    _stateId = json['stateId'];
    _stateName = json['stateName'];
    _distance = json['distance'];
    _googleAddress = json['googleAddress'] != null
        ? new GoogleAddress.fromJson(json['googleAddress'])
        : null;
    _phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressId'] = this._addressId;
    data['userId'] = this._userId;
    data['fullAddress'] = this._fullAddress;
    data['lat'] = this._lat;
    data['long'] = this._long;
    data['companyName'] = this._companyName;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['add1'] = this._add1;
    data['add2'] = this._add2;
    data['city'] = this._city;
    data['postalCode'] = this._postalCode;
    data['countryId'] = this._countryId;
    data['countryName'] = this._countryName;
    data['stateId'] = this._stateId;
    data['stateName'] = this._stateName;
    data['distance'] = this._distance;
    if (this._googleAddress != null) {
      data['googleAddress'] = this._googleAddress.toJson();
    }
    data['phone'] = this._phone;
    return data;
  }
}

class GoogleAddress {
  String _city;
  String _country;
  String _state;
  String _placeName;
  String _fullAddress;
  String _placeId;

  GoogleAddress(
      {String city,
        String country,
        String state,
        String placeName,
        String fullAddress,
        String placeId}) {
    this._city = city;
    this._country = country;
    this._state = state;
    this._placeName = placeName;
    this._fullAddress = fullAddress;
    this._placeId = placeId;
  }

  String get city => _city;
  set city(String city) => _city = city;
  String get country => _country;
  set country(String country) => _country = country;
  String get state => _state;
  set state(String state) => _state = state;
  String get placeName => _placeName;
  set placeName(String placeName) => _placeName = placeName;
  String get fullAddress => _fullAddress;
  set fullAddress(String fullAddress) => _fullAddress = fullAddress;
  String get placeId => _placeId;
  set placeId(String placeId) => _placeId = placeId;

  GoogleAddress.fromJson(Map<String, dynamic> json) {
    _city = json['city'];
    _country = json['country'];
    _state = json['state'];
    _placeName = json['placeName'];
    _fullAddress = json['fullAddress'];
    _placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this._city;
    data['country'] = this._country;
    data['state'] = this._state;
    data['placeName'] = this._placeName;
    data['fullAddress'] = this._fullAddress;
    data['placeId'] = this._placeId;
    return data;
  }
}
