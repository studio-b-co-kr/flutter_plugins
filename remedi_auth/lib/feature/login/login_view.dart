import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedi_auth/viewmodel/i_login_viewmodel.dart';
import 'package:remedi_widgets/text.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import '../../remedi_auth.dart';
import '../../resources/app_strings.dart';

class LoginView extends BindingView<ILoginViewModel> {
  final String logoBrand;
  final String logoCompany;

  LoginView({this.logoBrand, this.logoCompany})
      : assert(logoBrand != null),
        assert(logoCompany != null),
        super();

  @override
  Widget build(BuildContext context, ILoginViewModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Spacer(flex: 1),
            _buildImage(logoBrand, width: 200),
            Expanded(
              flex: 2,
              child: IndexedStack(index: _index(viewModel), children: [
                Container(),
                _buildError(viewModel),
                _buildProgress(viewModel),
              ]),
            ),
            _buildButtons(viewModel),
            _buildImage(logoCompany, width: 100),
            SizedBox(height: 16),
          ]),
        ),
      ),
    );
  }

  Widget _buildError(ILoginViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: ListView(shrinkWrap: true, children: [
        FixedScaleText(
          text: Text(
            "${viewModel.error?.title} (code : ${viewModel.error?.code})",
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 8),
        FixedScaleText(
          text: Text(
            "${viewModel.error?.message}",
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 8),
        kReleaseMode
            ? Container()
            : FixedScaleText(
                text: Text("${viewModel.error?.stackTrace}",
                    style: TextStyle(fontSize: 16)),
              ),
      ]),
    );
  }

  int _index(ILoginViewModel viewModel) {
    int ret = 0;
    switch (viewModel.state) {
      case LoginViewState.Loading:
        ret = 2;
        break;
      case LoginViewState.Error:
        ret = 1;
        break;
      case LoginViewState.Idle:
      default:
        ret = 0;
        break;
    }

    return ret;
  }

  Widget _buildProgress(ILoginViewModel viewModel) {
    return Container(
      alignment: Alignment.center,
      child:
          Container(width: 40, height: 40, child: CircularProgressIndicator()),
    );
  }

  Widget _buildButtons(ILoginViewModel viewModel) {
    List<Widget> buttons = [];
    if (AuthConfig.enableApple) {
      buttons.add(Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: MaterialButton(
            height: 48,
            minWidth: double.infinity,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            color: Colors.black,
            disabledColor: Colors.grey.shade300,
            disabledTextColor: Colors.grey.shade500,
            onPressed: viewModel.state == LoginViewState.Loading ||
                    viewModel.state == LoginViewState.Success
                ? null
                : () => viewModel.loginWithApple(),
            child: FixedScaleText(
              text: Text(
                AppStrings.loginWithApple,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )));
    }

    if (AuthConfig.enableKakao) {
      buttons.add(Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: MaterialButton(
            height: 48,
            elevation: 0,
            minWidth: double.infinity,
            color: Colors.yellow,
            disabledColor: Colors.grey.shade300,
            disabledTextColor: Colors.grey.shade500,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            onPressed: viewModel.state == LoginViewState.Loading ||
                    viewModel.state == LoginViewState.Success
                ? null
                : () => viewModel.loginWithKakao(),
            child: FixedScaleText(
              text: Text(
                AppStrings.loginWithKakao,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )));
    }
    return Column(children: buttons);
  }

  Widget _buildImage(String image, {double width}) {
    if (image == null) {
      return Icon(
        Icons.error_outline,
        color: Colors.red.shade400,
        size: width,
      );
    }

    if (image.contains("svg")) {
      return SvgPicture.asset(
        image,
        fit: BoxFit.contain,
        width: width,
      );
    }
    return Image.asset(
      image,
      fit: BoxFit.contain,
      width: width,
    );
  }
}
