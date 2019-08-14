class Rooms {
  int id;
  String _name;
  String _description;

  Rooms(this._name, this._description);

  Rooms.map(dynamic obj) {
    this._name = obj["name"];
    this._description = obj["description"];
  }

  String get name => _name;
  String get description => _description;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["description"] = _description;
    return map;
  }

  void setRoomId(int id) {
    this.id = id;
  }
}

class Checks {
  int id;
  String _name;
  String _description;

  Checks(this._name, this._description);

  Checks.map(dynamic obj) {
    this._name = obj["name"];
    this._description = obj["description"];
  }

  String get name => _name;
  String get description => _description;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["description"] = _description;
    return map;
  }

  void setCheckId(int id) {
    this.id = id;
  }
}

class Reports {
  int id;
  String _name;
  String _date;

  Reports(this._name, this._date);

  Reports.map(dynamic obj) {
    this._name = obj["name"];
    this._date = obj["date"];
  }

  String get name => _name;
  String get date => _date;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["date"] = _date;
    return map;
  }

  void setReportId(int id) {
    this.id = id;
  }
}

class ReportDataUnit {
  int id;
  int _report;
  int _check;
  int _value;

  ReportDataUnit(this._report, this._check, this._value);

  ReportDataUnit.map(dynamic obj) {
    this._report = obj["report"];
    this._check = obj["check"];
    this._value = obj["value"];
  }

  int get report => _report;
  int get check => _check;
  int get value => _value;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["report"] = _report;
    map["check"] = _check;
    map["value"] = _value;
    return map;
  }

  void setDataUnitId(int id) {
    this.id = id;
  }
}
