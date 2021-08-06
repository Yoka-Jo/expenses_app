class ProductData {
  int _id;
  String _productName;
  double _price;
  int _number;
  String _date;
  String _week;
  ProductData([this._productName, this._price, this._number, this._date, this._week]);

//  ProductData.withId(this._id, this._productName, this._price, this._number,
//      this._date , this._week);

  int get id => _id;

  String get productName => _productName;
  String get week => _week;

  double get price => _price;

  int get number => _number;

  String get date => _date;

  set productName(String newTitle) {
    this._productName = newTitle;
  }

  set week(String newTitle) {
    this._week = newTitle;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set price(double price) {
    this._price = price;
  }


  set number(int newDate) {
    this._number = newDate;
  }

  // Convert a Note object into a Map object
//  name varchar(50), price integer, number integer , date Text , week Text
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _productName;
    map['price'] = _price;
    map['number'] = _number;
    map['date'] = _date;
    map['week'] = _week;
    return map;
  }

  // Extract a Note object from a Map object
  ProductData.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._productName = map['title'];
    this._price = map['price'];
    this._number = map['number'];
    this._date = map['date'];
    this._week = map['week'];
  }
}