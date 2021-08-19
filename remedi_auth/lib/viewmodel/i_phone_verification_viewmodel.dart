import 'package:remedi_auth/phone_number_input/utils/phone_number.dart';

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
  requestingResendingCode,
  errorRequestingSendCode,
  inputCode,
  readyToVerify,
  verifyingCode,
  errorVerifyingCodeInvalid,
  errorVerifyingCodeExpired,
  waitingCodeReceive, // android only
  timeoutWaitingCodeReceive, // android only
  verifiedCode,
}
