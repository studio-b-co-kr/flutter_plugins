import 'package:example/features/contents/contents_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class ContentsPage extends ViewModelView<ContentsViewModel> {
  static const String routeName = '/contents';

  const ContentsPage({Key? key, required ContentsViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, ContentsViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contents'),
      ),
      body: const ContentWidget(data: 'Contents Page'),
    );
  }
}

class ContentWidget extends StatelessDataView<String> {
  const ContentWidget({Key? key, required String? data})
      : super(key: key, data: data);

  @override
  Widget buildWidget(BuildContext context, String? data) {
    return Column(
      children: [
        Expanded(
            child: Row(
          children: [
            Expanded(
                child: Container(
              color: Colors.red,
            )),
            Expanded(
                child: Container(
              color: Colors.orange,
            )),
          ],
        )),
        Expanded(
            child: Row(
          children: [
            Expanded(
                child: Container(
              color: Colors.yellow,
            )),
            Expanded(
                child: Container(
              color: Colors.blue,
            )),
          ],
        )),
      ],
    );
  }
}
