import 'package:flutter/material.dart';
import 'package:remedi_architecture/remedi_architecture.dart';

class ExampleStatelessDataView extends StatelessDataView<int> {
  const ExampleStatelessDataView({Key? key, required data})
      : super(key: key, data: data);

  @override
  Widget buildWidget(BuildContext context, data) {
    return Container();
  }
}
