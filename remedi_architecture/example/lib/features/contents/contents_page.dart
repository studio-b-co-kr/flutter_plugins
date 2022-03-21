import 'package:example/features/contents/contents_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class ContentsPage extends IViewModelView<ContentsViewModel> {
  static const routeName = '/contents';

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

class ContentWidget extends IStatelessDataView<String> {
  const ContentWidget({Key? key, required String? data})
      : super(key: key, data: data);

  @override
  Widget buildWidget(BuildContext context, String? data) {
    return Center(
      child: Text(
        data ?? '',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
