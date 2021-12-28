import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remedi_splash/view_model/i_splash_view_model.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class SplashView extends IView<ISplashViewModel> {
  final Widget widget;
  final Color? color;

  SplashView({required this.widget, this.color});

  @override
  Widget build(BuildContext buildContext, ISplashViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Spacer(flex: 1),
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
              SizedBox(height: 16),
            ]),
          ]),
        ),
      ),
    );
  }
}
