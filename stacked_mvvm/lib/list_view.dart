part of 'stacked_mvvm.dart';

class ListItemsBuilder<I extends IView> {
  final List<I> items = [];

  List<I> build() {
    return items;
  }

  int get count => items.length;

  refresh() {}
}

abstract class ListBindingView<VM extends IViewModel> extends IView<VM> {
  final ListItemsBuilder itemsBuilder;

  ListBindingView({required this.itemsBuilder});

  @override
  Widget build(BuildContext context, VM viewModel) {
    itemsBuilder.build();
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return buildItem(context, index);
      },
      separatorBuilder: (context, index) {
        return buildSeparator(context, index);
      },
      itemCount: itemsBuilder.count,
    );
  }

  Widget buildSeparator(BuildContext context, int index);

  Widget buildItem(BuildContext context, int index);
}
