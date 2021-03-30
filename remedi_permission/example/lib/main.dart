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
          MaterialPageRoute? ret;
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
                  await Navigator.of(context).push(allRoute());
                },
                minWidth: double.maxFinite,
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("All Permissions"),
              ),
            )),
            Expanded(
                flex: 9,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: MaterialButton(
                    onPressed: () async {
                      await Navigator.of(context).push(locationRoute());
                    },
                    minWidth: double.maxFinite,
                    color: Colors.blueGrey,
                    textColor: Colors.white,
                    child: Text(
                        "Location Permissions\n\n For an App needs one permission or need to request JIT"),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  MaterialPageRoute allRoute() {
    return MaterialPageRoute(
      builder: (context) => PermissionListPage(
        viewModel: PermissionListViewModel(
            repository: PermissionListRepository(
          [
            AppPermission(
              Permission.camera,
              title: "camera",
              errorDescription: "앱 사용에 꼭 필요한 권한입니다.",
              description: "Please grant camera permission.",
              mandatory: true,
            ),
            AppPermission(Permission.location,
                title: "location",
                description: "Please grant location permission."),
            AppPermission(Permission.storage,
                title: "Storage",
                description: "Please grant storage permission."),
            // AppPermission(Permission.calendar,
            //     title: "calendar",
            //     description: "Please grant calendar permission."),
            // AppPermission(Permission.contacts,
            //     title: "contacts",
            //     description: "Please grant contacts permission."),
            //
            // AppPermission(Permission.microphone,
            //     title: "microphone",
            //     description: "Please grant microphone permission."),
            // AppPermission(Permission.sensors,
            //     title: "sensors",
            //     description: "Please grant sensors permission."),
            // AppPermission(
            //   Permission.sms,
            //   title: "sms",
            //   errorDescription: "Please Please Please",
            //   description: "Please grant sms permission.",
            //   mandatory: true,
            // ),
            // AppPermission(Permission.speech,
            //     title: "speech",
            //     description: "Please grant speech permission."),
            // AppPermission(Permission.ignoreBatteryOptimizations,
            //     title: "ignoreBatteryOptimizations",
            //     description:
            //         "Please grant ignoreBatteryOptimizations permission."),
            // AppPermission(Permission.mediaLibrary,
            //     title: "mediaLibrary",
            //     description: "Please grant mediaLibrary permission."),
            // AppPermission(Permission.photos,
            //     title: "photos",
            //     description: "Please grant photos permission."),
            // AppPermission(
            //   Permission.photosAddOnly,
            //   title: "photosAddOnly",
            //   errorDescription: "Please Please Please",
            //   description: "Please grant photosAddOnly permission.",
            //   mandatory: true,
            // ),
            // AppPermission(Permission.reminders,
            //     title: "reminders",
            //     description: "Please grant reminders permission."),
            // AppPermission(Permission.notification,
            //     title: "notification",
            //     description: "Please grant notification permission."),
            // AppPermission(Permission.bluetooth,
            //     title: "bluetooth",
            //     description: "Please grant bluetooth permission."),
            // AppPermission(Permission.phone,
            //     title: "phone", description: "Please grant phone permission."),
            // AppPermission(Permission.accessMediaLocation,
            //     title: "accessMediaLocation",
            //     description: "Please grant accessMediaLocation permission."),
            // AppPermission(Permission.activityRecognition,
            //     title: "activityRecognition",
            //     description: "Please grant activityRecognition permission."),
          ],
        )),
      ),
    );
  }

  MaterialPageRoute locationRoute() {
    return MaterialPageRoute(
      builder: (context) => PermissionPage(
        viewModel: PermissionViewModel(
          repository: PermissionRepository(
            AppPermission(Permission.location,
                title: "location",
                mandatory: true,
                errorDescription: "위치권한 없이는 앱을 사용할 수 없습니다.",
                description:
                    "Please grant location permission to use this app."),
          ),
        ),
      ),
    );
  }
}
