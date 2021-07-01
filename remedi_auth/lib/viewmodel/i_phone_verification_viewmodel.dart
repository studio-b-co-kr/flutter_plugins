import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:remedi_auth/model/phone_verification.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPhoneVerificationViewModel
    extends IViewModel<PhoneVerificationState> {
  PhoneNumber phoneNumber = PhoneNumber();
  PhoneVerification phoneVerification = PhoneVerification();

  onPhoneNumberValidated(bool valid);

  verificationCodeChanged(String code);

  requestSendCode();

  requestVerify();

  changePhoneNumber();
}

enum PhoneVerificationState {
  inputPhoneNumber,
  readyToSendCode,
  requestingSendCode,
  errorOnRequest,
  inputCode,
  readyToVerify,
  verifying,
  errorOnVerifying,
  timeout,
  verified,
}
