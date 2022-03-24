import 'package:example/features/contents/contents_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi.dart';

class ContentsPage extends ViewModelBuilder<ContentsViewModel> {
  static const String routeName = '/contents';

  const ContentsPage({
    Key? key,
    required ContentsViewModel viewModel,
  }) : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contents'),
      ),
      body: _build(context),
    );
  }

  Widget _build(
    BuildContext context,
  ) {
    return Column(children: [
      Expanded(
          child: Row(
        children: [
          Expanded(
            child: RouteView(
              title: 'Example\nStateless\nDataView',
              description: '',
              buttonTitle: 'Go\nStateless\nDataView\nExample',
              onPressed: () {
                viewModel.goStatelessDataView();
              },
            ),
          ),
          Expanded(
            child: RouteView(
              title: 'Example\nStateless\nStateDataView',
              description: '',
              buttonTitle: 'Go\nStateless\nStateDataView\nExample',
              onPressed: () {
                viewModel.goStatelessStateDataView();
              },
            ),
          ),
        ],
      )),
      Expanded(
          child: Row(children: [
        Expanded(
          child: RouteView(
            title: 'Example\nStateful\nDataView',
            description: '',
            buttonTitle: 'Go\nStateful\nDataView\nExample',
            onPressed: () {
              viewModel.goStatefulDataView();
            },
          ),
        ),
        Expanded(
          child: RouteView(
            title: 'Example\nStateful\nStateDataView',
            description: '',
            buttonTitle: 'Go\nStateful\nStateDataView\nExample',
            onPressed: () {
              viewModel.goStatefulStateDataView();
            },
          ),
        ),
      ])),
    ]);
  }
}

class RouteView extends StatelessWidget {
  final String title;
  final String description;
  final String buttonTitle;
  final void Function() onPressed;

  const RouteView({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonTitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Text(title),
        ),
        Expanded(
          child: Center(
            child: Text(
              description,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: MaterialButton(
            minWidth: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey,
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ]),
    );
  }
}
