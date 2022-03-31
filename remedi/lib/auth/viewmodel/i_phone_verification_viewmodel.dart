import 'package:remedi/auth/phone_number_input/utils/phone_number.dart';
import 'package:remedi/remedi.dart';

abstract class IPhoneVerificationViewModel extends ViewModel {
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
