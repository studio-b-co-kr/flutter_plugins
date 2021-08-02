import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';

class PhoneVerificationViewModel extends IPhoneVerificationViewModel {
  _PhoneVerification _phoneVerification = _PhoneVerification();

  @override
  PhoneVerificationState get initState =>
      PhoneVerificationState.inputPhoneNumber;

  @override
  requestVerify() async {
    update(state: PhoneVerificationState.verifyingCode);

    PhoneAuthCredential credential = await PhoneAuthProvider.credential(
      verificationId: _phoneVerification.verificationId!,
      smsCode: _phoneVerification.verificationCode!,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      await FirebaseAuth.instance.signOut();
      update(state: PhoneVerificationState.verifiedCode);
    } catch (e) {
      _handleError(e as FirebaseAuthException);
    }
  }

  @override
  onPhoneNumberValidated(bool valid) {
    if (valid) {
      update(state: PhoneVerificationState.readyToSendCode);
    } else {
      update(state: PhoneVerificationState.inputPhoneNumber);
    }
  }

  String? _prevCode;

  @override
  verificationCodeChanged(String code) {
    if (code.length == 6) {
      _phoneVerification.phoneNumber = phoneNumber.phoneNumber!;
      _phoneVerification.verificationCode = code;
      update(state: PhoneVerificationState.readyToVerify);
      requestVerify();
    } else if (_prevCode?.length == 6 && code.length != 6) {
      _phoneVerification.verificationCode = code;
      update(state: PhoneVerificationState.inputCode);
    }
    _prevCode = code;
  }

  @override
  requestSendCode() async {
    update(state: PhoneVerificationState.requestingSendCode);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber.phoneNumber!,
      timeout: Duration(seconds: 30),
      forceResendingToken: _phoneVerification.resendToken,
      verificationCompleted: (PhoneAuthCredential credential) {
        update(state: PhoneVerificationState.verifiedCode);
      },
      verificationFailed: (FirebaseAuthException e) {
        _handleError(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        _phoneVerification.verificationId = verificationId;
        _phoneVerification.resendToken = resendToken;
        update(state: PhoneVerificationState.inputCode);
        if (Platform.isAndroid) {
          update(state: PhoneVerificationState.waitingCodeReceive);
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _phoneVerification.verificationId = verificationId;
        if (Platform.isAndroid) {
          update(state: PhoneVerificationState.timeoutWaitingCodeReceive);
        }
      },
    );
  }

  _handleError(FirebaseAuthException exception) {
    if (exception.code == "too-many-requests") {
      update(state: PhoneVerificationState.errorRequestingSendCode);
      return;
    }

    if ((exception).code == "session-expired") {
      _phoneVerification.verificationCode = "";
      update(state: PhoneVerificationState.errorVerifyingCodeExpired);
      return;
    }

    if ((exception).code == "invalid-verification-code") {
      _phoneVerification.verificationCode = "";
      update(state: PhoneVerificationState.errorVerifyingCodeInvalid);
      return;
    }

    if ((exception).code == "unknown") {
      _phoneVerification.verificationCode = "";
      update(state: PhoneVerificationState.errorRequestingSendCode);
      return;
    }
  }

  @override
  changePhoneNumber() {
    _reset();
    update(state: PhoneVerificationState.inputPhoneNumber);
  }

  _reset() {
    phoneNumber = PhoneNumber();
    _phoneVerification = _PhoneVerification();
  }

  @override
  String get verificationCode => _phoneVerification.verificationCode ?? "";
}

class _PhoneVerification {
  String? phoneNumber;
  String? verificationCode;
  int? resendToken;
  String? verificationId;

  _PhoneVerification();
}
