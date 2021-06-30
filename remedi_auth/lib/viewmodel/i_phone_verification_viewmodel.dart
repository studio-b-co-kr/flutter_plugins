import 'package:remedi_auth/feature/phone_verification/phone_verification_view.dart';
import 'package:remedi_auth/repository/i_phone_verification_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPhoneVerificationViewModel
    extends IViewModel<PhoneVerificationState> {
  IPhoneVerificationRepository get repository;

  requestVerify(PhoneVerification verification);
}
