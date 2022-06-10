class CategoryMaster {
  int _success;
  int _total;
  List<CategoriesDetails> _result;

  CategoryMaster({int success, int total, List<CategoriesDetails> result}) {
    this._success = success;
    this._total = total;
    this._result = result;
  }

  int get success => _success;
  set success(int success) => _success = success;
  int get total => _total;
  set total(int total) => _total = total;
  List<CategoriesDetails> get result => _result;
  set result(List<CategoriesDetails> result) => _result = result;

  CategoryMaster.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _total = json['total'];
    if (json['result'] != null) {
      _result = new List<CategoriesDetails>();
      json['result'].forEach((v) {
        _result.add(new CategoriesDetails.fromJson(v));
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

class CategoriesDetails {
  String _catId;
  String _name;
  String _thumbImage;
  String _metaTitle;
  int _hasSubCategory;

  CategoriesDetails(
      {String catId,
        String name,
        String thumbImage,
        String metaTitle,
        int hasSubCategory}) {
    this._catId = catId;
    this._name = name;
    this._thumbImage = thumbImage;
    this._metaTitle = metaTitle;
    this._hasSubCategory = hasSubCategory;
  }

  String get catId => _catId;
  set catId(String catId) => _catId = catId;
  String get name => _name;
  set name(String name) => _name = name;
  String get thumbImage => _thumbImage;
  set thumbImage(String thumbImage) => _thumbImage = thumbImage;
  String get metaTitle => _metaTitle;
  set metaTitle(String metaTitle) => _metaTitle = metaTitle;
  int get hasSubCategory => _hasSubCategory;
  set hasSubCategory(int hasSubCategory) => _hasSubCategory = hasSubCategory;

  CategoriesDetails.fromJson(Map<String, dynamic> json) {
    _catId = json.containsKey('catId') ? json['catId'] : json['subCatId'];
    _name = json['name'];
    _thumbImage = json['thumbImage'];
    _metaTitle = json['meta_title'];
    _hasSubCategory = json['hasSubCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catId'] = this._catId;
    data['name'] = this._name;
    data['thumbImage'] = this._thumbImage;
    data['meta_title'] = this._metaTitle;
    data['hasSubCategory'] = this._hasSubCategory;
    return data;
  }
}
