import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remedi_splash/view_model/i_splash_view_model.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class SplashView extends IView<ISplashViewModel> {
  final Widget widget;
  final Color? color;
  final bool? showLoading;

  SplashView({
    required this.widget,
    this.color,
    this.showLoading = true,
  });

  @override
  Widget build(BuildContext buildContext, ISplashViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Stack(children: [
            widget,
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(flex: 1),
                    Expanded(
                      flex: 3,
                      child: Column(children: [
                        Spacer(flex: 1),
                        viewModel.state == SplashViewState.Error &&
                                viewModel.splashError != null
                            ? Container(
                                padding: EdgeInsets.all(16),
                                margin: EdgeInsets.all(16),
                                color: Colors.grey.shade200,
                                width: double.infinity,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Text(
                                      "${viewModel.splashError!.title} (code : ${viewModel.splashError!.code})",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "${viewModel.splashError!.message}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(height: 8),
                                    kReleaseMode
                                        ? Container()
                                        : Text(
                                            "${viewModel.splashError!.body}",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                  ],
                                ),
                              )
                            : (showLoading ?? true)
                                ? Container(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(),
                        Spacer(flex: 1),
                      ]),
                    ),
                    SizedBox(height: 16),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
