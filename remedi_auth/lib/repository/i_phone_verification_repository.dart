import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPhoneVerificationRepository extends IRepository {
  Stream<PhoneVerificationState> requestSendCode(String phoneNumber);

  Stream<PhoneVerificationState> verify(String verificationCode);

  Stream<PhoneVerificationState> cancelVerification();
}
