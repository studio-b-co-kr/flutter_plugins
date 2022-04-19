import 'package:example/features/contents/contents_view_model.dart';
import 'package:flutter/material.dart';
import 'package:remedi_flutter/remedi_flutter.dart';

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
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          onPressed: () {
            read.increase();
          },
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.grey.shade50,
          ),
        ),
      ),
      body: Column(children: [
        const Expanded(
          child: Center(
            child: CountView(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: MaterialButton(
            color: Colors.grey,
            height: 48,
            minWidth: double.infinity,
            onPressed: () {
              RemediRouter.pushNamed(routeName);
            },
            child: const Text('Go Contents'),
          ),
        )
      ]),
    );
  }
}

class CountView extends ViewModelView<ContentsViewModel> {
  const CountView({Key? key}) : super(key: key);

  @override
  Widget buildChild(
      BuildContext context, ContentsViewModel watch, ContentsViewModel read) {
    return Text(
      '${watch.count}',
      style: const TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
