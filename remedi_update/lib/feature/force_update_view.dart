import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remedi_update/viewmodel/i_force_update_viewmodel.dart';
import 'package:remedi_widgets/text.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

import '../remedi_update.dart';
import '../resources/app_strings.dart';

class ForceUpdateView extends BindingView<IForceUpdateViewModel> {
  final String? image;

  ForceUpdateView({this.image});

  @override
  Widget build(BuildContext context, IForceUpdateViewModel viewModel) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              _buildImage(context, viewModel),
              Spacer(flex: 1),
              _buildDescription(context, viewModel),
              Spacer(flex: 1),
              _buildButton(context, viewModel),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, IForceUpdateViewModel viewModel) {
    if (image == null) {
      return Icon(
        Icons.error_outline,
        color: Colors.red.shade400,
        size: 120,
      );
    }

    if (image!.contains("svg")) {
      return SvgPicture.asset(
        image!,
        fit: BoxFit.contain,
        width: 200,
        height: 200,
      );
    }
    return Image.asset(
      image!,
      fit: BoxFit.contain,
      width: 200,
      height: 200,
    );
  }

  Widget _buildDescription(
      BuildContext context, IForceUpdateViewModel viewModel) {
    return FixedScaleText(
        text: Text(
      AppStrings.description,
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    ));
  }

  Widget _buildButton(BuildContext context, IForceUpdateViewModel viewModel) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: MaterialButton(
            height: 40,
            textTheme: ButtonTextTheme.accent,
            minWidth: double.maxFinite,
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              viewModel.goToUpdate();
            },
            child: FixedScaleText(text: Text(AppStrings.goToStore))));
  }
}
