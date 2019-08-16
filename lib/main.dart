import 'package:flutter/material.dart';
import 'db.dart';
import 'structs.dart';
import 'reports_presenter.dart';
import 'reports_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checklist App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Checklist App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements ReportContract {
  int _counter = 0;

  ReportsPresenter reportsPresenter;

  @override
  void initState() {
    super.initState();
    reportsPresenter = new ReportsPresenter(this);
  }

  displayRecord() {
    setState(() {
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              // Nothing
            }
          )
        ],
      ),
      body: new FutureBuilder<List<Reports>>(
        future: ReportsPresenter.getReports(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var data = snapshot.data;
          return snapshot.hasData ?
              new ReportsList(data, reportsPresenter) :
              new Center(child: new CircularProgressIndicator());
        },
      )
    );
  }

  @override
  void screenUpdate() {
    setState(() {
    });
  }
}
