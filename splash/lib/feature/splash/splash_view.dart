import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiscreen/multiscreen.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import '../../splash.dart';

class SplashView extends BindingView<ISplashViewModel> {
  final String logoBrand;
  final String logoCompany;

  SplashView({this.logoBrand, this.logoCompany});

  @override
  Widget build(BuildContext buildContext, ISplashViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Spacer(flex: 1),
            _images(
              buildContext,
              image: logoBrand,
              width: resize(200),
            ),
            Expanded(
              flex: 3,
              child: Column(children: [
                Spacer(flex: 1),
                viewModel.state == SplashViewState.Error
                    ? Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.grey.shade200,
                        width: resize(320),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Text(
                              "${viewModel.error.title} (code : ${viewModel.error.code})",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${viewModel.error.message}",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            kReleaseMode
                                ? Container()
                                : Text(
                                    "${viewModel.error.stackTrace}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ],
                        ),
                      )
                    : Container(
                        width: resize(40),
                        height: resize(40),
                        child: CircularProgressIndicator(),
                      ),
                Spacer(flex: 1),
              ]),
            ),
            _images(
              buildContext,
              image: logoCompany,
              width: 100,
            ),
            SizedBox(height: resize(16)),
          ]),
        ),
      ),
    );
  }

  Widget _images(BuildContext buildContext, {String image, double width}) {
    if (image == null) {
      return Container(height: width / 4, width: width);
    }

    if (image.contains("svg")) {
      return SvgPicture.asset(
        image,
        width: resize(width),
      );
    }
    return Image.asset(
      image,
      width: resize(width),
    );
  }
}
