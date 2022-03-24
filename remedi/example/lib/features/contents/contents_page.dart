import 'package:example/features/contents/contents_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi/remedi.dart';

class ContentsPage extends ViewModelBuilder<ContentsViewModel> {
  static const String routeName = '/contents';

  ContentsPage({
    Key? key,
    required ContentsViewModel viewModel,
  }) : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, ContentsViewModel read) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contents'),
      ),
      body: const Center(
        child: Text(
          'Contents',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
