import 'package:remedi/auth/viewmodel/i_phone_verification_viewmodel.dart';

import '../../remedi.dart';

abstract class IPhoneVerificationRepository extends Repository {
  Stream<PhoneVerificationState> requestSendCode(String phoneNumber);

  Stream<PhoneVerificationState> verify(String verificationCode);

  Stream<PhoneVerificationState> cancelVerification();
}
