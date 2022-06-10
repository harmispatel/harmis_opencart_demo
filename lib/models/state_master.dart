class StateMaster {
  int _success;
  List<StateDetails> _result;

  StateMaster({int success, List<StateDetails> result}) {
    this._success = success;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  List<StateDetails> get result => _result;
  set result(List<StateDetails> result) => _result = result;

  StateMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    if (json['result'] != null) {
      _result = new List<StateDetails>();
      json['result'].forEach((v) {
        _result.add(new StateDetails.fromJson(v));
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

class StateDetails {
  String _stateId;
  String _stateName;

  StateDetails({String stateId, String stateName}) {
    this._stateId = stateId;
    this._stateName = stateName;
  }

  String get stateId => _stateId;
  set stateId(String stateId) => _stateId = stateId;
  String get stateName => _stateName;
  set stateName(String stateName) => _stateName = stateName;

  StateDetails.fromJson(Map<String, dynamic> json) {
    _stateId = json['stateId'];
    _stateName = json['stateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stateId'] = this._stateId;
    data['stateName'] = this._stateName;
    return data;
  }
}