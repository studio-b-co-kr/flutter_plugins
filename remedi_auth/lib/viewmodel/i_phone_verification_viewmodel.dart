import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';

abstract class IPhoneVerificationViewModel
    extends IViewModel<PhoneVerificationState> {
  PhoneNumber phoneNumber = PhoneNumber();

  onPhoneNumberValidated(bool valid);

  verificationCodeChanged(String code);

  requestSendCode();

  requestVerify();

  changePhoneNumber();

  String get verificationCode;
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
