import 'package:flutter/material.dart';
import 'package:remedi_permission/viewmodel/i_permission_viewmodel.dart';
import 'package:remedi_widgets/remedi_widgets.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

class PermissionListItemWidget extends BaseWidget<IPermissionViewModel> {
  PermissionListItemWidget(IPermissionViewModel viewModel)
      : super(viewModel: viewModel);

  @override
  BindingView<IPermissionViewModel> body(
      BuildContext context, IPermissionViewModel viewModel, Widget child) {
    return PermissionListItemView();
  }

  @override
  void onListen(BuildContext context, IPermissionViewModel viewModel) {
    super.onListen(context, viewModel);
  }
}

class PermissionListItemView extends BindingView<IPermissionViewModel> {
  @override
  Widget build(BuildContext context, IPermissionViewModel viewModel) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      child: InkWell(
        onTap: () {
          viewModel.requestPermission();
        },
        child: Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: viewModel.icon,
                ),
              ),
              Container(
                  child: FixedScaleText(
                      text: Text(
                viewModel.title,
                style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontWeight: FontWeight.bold),
              ))),
              Spacer(),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blueGrey.shade50,
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 24,
                  color: Colors.blueGrey.shade700,
                ),
              )
            ]),
            SizedBox(height: 8),
            Container(child: Text(viewModel.description)),
          ]),
        ),
      ),
    );
  }
}
