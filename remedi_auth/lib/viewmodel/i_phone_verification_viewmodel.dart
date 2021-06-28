import 'package:remedi_auth/repository/i_phone_verification_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPhoneVerificationViewModel
    extends IViewModel<PhoneVerificationState> {
  IPhoneVerificationRepository get repository;

  int? get forceResendingToken;
}

enum PhoneVerificationState {
  init,
  requested,
  sent,
  error,
  expired,
  verifying,
  verified,
}
