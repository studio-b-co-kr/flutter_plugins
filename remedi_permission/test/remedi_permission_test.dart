import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remedi_permission/features/permission_list_item.dart';
import 'package:remedi_permission/remedi_permission.dart';
import 'package:remedi_permission/repository/i_permission_repository.dart';
import 'package:remedi_permission/viewmodel/i_permission_viewmodel.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

void main() {
  testWidgets('PermissionListItemView', (WidgetTester tester) async {
    TestRepository repository;
    TestViewModel viewModel;
    setUp(() {
      repository = TestRepository(AppPermission(Permission.photos));
      viewModel = TestViewModel(repository);
    });

    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        child: TestWidget(viewModel),
      ),
    ));
  });
}

class TestRepository extends IPermissionRepository {
  TestRepository(AppPermission permission) : super(permission: permission);

  @override
  Future goToSettings() {}

  @override
  Future init() {}

  @override
  bool get isDenied => false;

  @override
  bool get isError => false;

  @override
  bool get isGranted => false;

  @override
  bool get isPermanentlyDenied => false;

  @override
  Future<PermissionStatus> request() {
    return null;
  }

  @override
  Future<PermissionStatus> readPermissionStatus() async {
    return status = PermissionStatus.denied;
  }
}

class TestViewModel extends IPermissionViewModel {
  TestViewModel(IPermissionRepository repository)
      : super(repository: repository);

  @override
  String get description => "DESCRIPTION";

  @override
  String get errorDescription => "ERROR";

  @override
  PermissionViewState get initState => PermissionViewState.Init;

  @override
  String get title => "TITLE";

  @override
  String get statusMessage => "STATUS";

  @override
  Future refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }

  @override
  Future<PermissionStatus> requestPermission() {
    throw UnimplementedError();
  }

  @override
  Widget icon({double size}) {
    return Container(color: Colors.red);
  }

  @override
  // TODO: implement canSkip
  Future<bool> get canSkip => throw UnimplementedError();

  @override
  Future goToSettings() {
    // TODO: implement goToSettings
    throw UnimplementedError();
  }
}

class TestWidget extends BaseWidget<IPermissionViewModel> {
  TestWidget(IPermissionViewModel viewModel) : super(viewModel: viewModel);

  @override
  BindingView<IPermissionViewModel> body(
      BuildContext context, IPermissionViewModel viewModel, Widget child) {
    return PermissionListItemView();
  }
}
