import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IForceUpdateViewModel extends IViewModel<ForceUpdateViewState> {
  goToUpdate();
}

enum ForceUpdateViewState { Init }
