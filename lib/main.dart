import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

// ...
void main() async {
  runZonedGuarded<Future<void>>(() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    if (kDebugMode) {
// Force disable Crashlytics collection while doing every day development.
// Temporarily toggle this to true if you want to test crash reporting in your app.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(true);
    } else {
// Handle Crashlytics enabled status when not in Debu0g,
// e.g. allow your users to opt-in to crash reporting.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(true);
    }
    FirebaseCrashlytics.instance.setCustomKey('vipin', 'invalid index');
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));

  runApp(MyApp());
}

List a = [12];
class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot){
          if(snapshot.hasError){
            print('You have an error ${snapshot.error.toString()}');
            return Text('Something went wrong');
          }
          else if(snapshot.hasData){
            return MyHomePage(title: 'Flutter Demo Home Page');
          }
          else{
            return Center(
            child: CircularProgressIndicator()
            );
          }
        },
      )
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: (){
              // list.add("add");
              // try{
              //   print(a[1]);
              // }
              // catch(err){
              //   throw Error();
              // }
                print("22222222222222222222222 : hello");
              FirebaseCrashlytics.instance.crash();



            }, child: Text("Click me to crash the app")),
            RaisedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Scaffold(body: Center(child: Text("second screen"),))));
            }, child: Text("Go th other screen"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
