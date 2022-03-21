import 'package:example/features/content/contents_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/mvvm/mvvm.dart';

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
      body: const Center(
        child: Text('Contents Page'),
      ),
    );
  }
}
