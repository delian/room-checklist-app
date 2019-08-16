import 'db.dart';
import 'structs.dart';
import 'dart:async';

abstract class ReportContract {
  void screenUpdate();
}

class ReportsPresenter {
  ReportContract _view;
  var db = new DatabaseHelper();
  ReportsPresenter(this._view);
  delete(Reports report) {
    var db = new DatabaseHelper();
    db.deleteReport(report);
    updateScreen();
  }

  Future<List<Reports>> getReports() {
    return db.getReports();
  }

  updateScreen() {
    _view.screenUpdate();
  }
}