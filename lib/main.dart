import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  FlutterLocalNotificationsPlugin flutterNotification;

  @override
  void initState() {
    super.initState();
    var androidInitialize = AndroidInitializationSettings('app_icon');
    var iosInitilize = IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(androidInitialize, iosInitilize);
    flutterNotification = FlutterLocalNotificationsPlugin();
    flutterNotification.initialize(initializationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
        "Channel ID", "Andrés Programming", "This is my channel",
        playSound: true,
        importance: Importance.Max,
        enableLights: true,
        enableVibration: true);
    var iosDetails = IOSNotificationDetails();
    var generalNotificationsDetails =
        NotificationDetails(androidDetails, iosDetails);

    await flutterNotification.show(0, "Parking activo",
        "tu parking ha iniciado", generalNotificationsDetails,
        payload: "Andres");
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
            Text(
              'Esta es una App para probrar las notificaciones',
            ),
            RaisedButton(
              child: Text("Notificacion!"),
              onPressed: _showNotification,
            )
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future notificationSelected(String paylod) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Holas! $paylod"),
            ));
  }
}
