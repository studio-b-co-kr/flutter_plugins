import 'package:flutter/material.dart';
import 'package:remedi_permission/remedi_permission.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Permission Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomePage.ROUTE_NAME,
        onGenerateRoute: (settings) {
          MaterialPageRoute ret;
          switch (settings.name) {
            case HomePage.ROUTE_NAME:
              ret = MaterialPageRoute(
                  settings: settings, builder: (context) => HomePage());
              break;
          }
          return ret;
        });
  }
}

class HomePage extends StatelessWidget {
  static const String ROUTE_NAME = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Permission Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: MaterialButton(
                onPressed: () async {
                  await Navigator.of(context).push(generateRoute());
                },
                minWidth: double.maxFinite,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("All Permissions"),
              ),
            )),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: MaterialButton(
                onPressed: () {},
                minWidth: double.maxFinite,
                color: Colors.blueGrey,
                textColor: Colors.white,
                child: Text("Location Permissions"),
              ),
            )),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: MaterialButton(
                onPressed: () {},
                minWidth: double.maxFinite,
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Camera Permissions"),
              ),
            )),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: MaterialButton(
                onPressed: () {},
                minWidth: double.maxFinite,
                color: Colors.purple,
                textColor: Colors.white,
                child: Text("Storage Permissions"),
              ),
            )),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: MaterialButton(
                onPressed: () {},
                minWidth: double.maxFinite,
                color: Colors.purple,
                textColor: Colors.white,
                child: Text("Photo Permissions"),
              ),
            )),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: MaterialButton(
                onPressed: () {},
                minWidth: double.maxFinite,
                color: Colors.amber.shade700,
                textColor: Colors.white,
                child: Text("Notification Permissions(iOS only)"),
              ),
            )),
          ],
        ),
      ),
    );
  }

  MaterialPageRoute generateRoute() {
    return MaterialPageRoute(
      builder: (context) => PermissionListPage(
        viewModel: PermissionListViewModel([
          AppPermission(Permission.notification,
              icon: Icon(Icons.notifications_active_outlined),
              title: "Notification",
              description: "Please grant notification permission.",
              mandatory: false,
              platform: PermissionPlatform.ios),
          AppPermission(Permission.location,
              icon: Icon(Icons.location_on_outlined),
              title: "Location",
              description: "Please grant notification permission.",
              mandatory: true,
              platform: PermissionPlatform.both),
          AppPermission(Permission.camera,
              icon: Icon(Icons.camera_alt_outlined),
              title: "Camera",
              description: "Please grant notification permission.",
              platform: PermissionPlatform.both),
          AppPermission(Permission.photos,
              icon: Icon(Icons.photo_camera_back),
              title: "Photos",
              description: "Please grant notification permission."),
          AppPermission(Permission.storage,
              icon: Icon(Icons.sd_storage_outlined),
              title: "Storage",
              description: "Please grant notification permission."),
        ]),
      ),
    );
  }
}
