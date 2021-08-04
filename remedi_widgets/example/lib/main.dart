import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:remedi_widgets/multi_format_image.dart';
import 'package:remedi_widgets/phone_number/phone_number_input.dart';

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
      ),
      supportedLocales: [
        const Locale("en", "US"),
        const Locale("ko", "KR"),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Number input")),
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                PhoneNumberInput(
                  // countryCode: Localizations.localeOf(context).countryCode,
                  countryCode: 'US',
                ),
                SizedBox(height: 32),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: MediaQuery.of(context).size.width / 4 - 16,
                      child: MultiFormatImage.network(
                        "https://remedi-website.s3.ap-northeast-2.amazonaws.com/data/achoo/history_month/moon.svg",
                        format: ImageFormat.svg,
                        fit: BoxFit.contain,
                      ),
                    )),
                    SizedBox(width: 8),
                    Expanded(
                        child: Container(
                      height: MediaQuery.of(context).size.width / 4 - 16,
                      color: Colors.red,
                    )),
                    SizedBox(width: 8),
                    Expanded(
                        child: Container(
                      height: MediaQuery.of(context).size.width / 4 - 16,
                      color: Colors.red,
                    )),
                    SizedBox(width: 8),
                    Expanded(
                        child: Container(
                      height: MediaQuery.of(context).size.width / 4 - 16,
                      color: Colors.red,
                    )),
                  ],
                )),
              ],
            )),
      ),
    );
  }
}
