import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPhoneVerificationViewModel
    extends IViewModel<PhoneVerificationViewState> {
  IPhoneVerificationViewModel() : super();
}

enum PhoneVerificationViewState {
  Init,
  Completed,
  Sent,
  Fail,
}
