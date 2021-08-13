import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedi_splash/view_model/i_splash_view_model.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class SplashView extends IView<ISplashViewModel> {
  final String? logoBrand;
  final String? logoCompany;
  final Color? color;

  SplashView({this.logoBrand, this.logoCompany, this.color});

  @override
  Widget build(BuildContext buildContext, ISplashViewModel viewModel) {
    return Scaffold(
      backgroundColor: color ?? Colors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Spacer(flex: 1),
            _images(
              buildContext,
              image: logoBrand,
              width: 200,
            ),
            Expanded(
              flex: 3,
              child: Column(children: [
                Spacer(flex: 1),
                viewModel.state == SplashViewState.Error &&
                        viewModel.appError != null
                    ? Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        color: Colors.grey.shade200,
                        width: double.infinity,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Text(
                              "${viewModel.appError!.title} (code : ${viewModel.appError!.code})",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "${viewModel.appError!.message}",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            kReleaseMode
                                ? Container()
                                : Text(
                                    "${viewModel.appError!.stackTrace}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ],
                        ),
                      )
                    : Container(
                        width: 40,
                        height: 40,
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
            SizedBox(height: 16),
          ]),
        ),
      ),
    );
  }

  Widget _images(BuildContext buildContext,
      {String? image, double width = 200}) {
    if (image == null || image.isEmpty) {
      return Container(height: width / 4, width: width);
    }

    if (image.contains("svg")) {
      return SvgPicture.asset(
        image,
        width: width,
      );
    }
    return Image.asset(
      image,
      width: width,
    );
  }
}
