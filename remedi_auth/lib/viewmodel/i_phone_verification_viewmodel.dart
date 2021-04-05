import 'package:remedi_auth/repository/i_phone_verification_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPhoneVerificationViewModel extends BaseViewModel<
    PhoneVerificationViewState, IPhoneVerificationRepository> {
  IPhoneVerificationViewModel(
      {required IPhoneVerificationRepository repository})
      : super(repository: repository);
}

enum PhoneVerificationViewState {
  Init,
  Completed,
  Sent,
  Fail,
}
