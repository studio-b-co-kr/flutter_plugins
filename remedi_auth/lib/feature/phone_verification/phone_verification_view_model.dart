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
    update(state: PhoneVerificationState.readyToVerify);
    update(state: PhoneVerificationState.verifying);
    await Future.delayed(Duration(seconds: 2));

    update(state: PhoneVerificationState.errorOnVerifying);

    // PhoneAuthCredential credential = await PhoneAuthProvider.credential(
    //   verificationId: _verificationId!,
    //   smsCode: phoneVerification.verificationCode!,
    // );
    // UserCredential userCredential;
    // try {
    //   userCredential =
    //       await FirebaseAuth.instance.signInWithCredential(credential);
    // } catch (e) {
    //   _handleError(e as FirebaseAuthException);
    //   return;
    // }
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
      update(state: PhoneVerificationState.inputCode);
    }
    _prevCode = code;
  }

  @override
  requestSendCode() async {
    update(state: PhoneVerificationState.requestingSendCode);

    await Future.delayed(Duration(seconds: 2));
    _phoneVerification.resendToken = 123456;
    _phoneVerification.verificationId = "1230";
    update(state: PhoneVerificationState.inputCode);
    // update(state: PhoneVerificationState.errorOnVerifying);
    // update(state: PhoneVerificationState.errorOnRequest);
    // update(state: PhoneVerificationState.timeout);

    // FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: phoneNumber.phoneNumber!,
    //   timeout: Duration(minutes: 3),
    //   forceResendingToken: _resendToken,
    //   verificationCompleted: (PhoneAuthCredential credential) {
    //     update(state: PhoneVerificationState.verified);
    //   },
    //   verificationFailed: (FirebaseAuthException e) {
    //     update(state: PhoneVerificationState.errorOnRequest);
    //   },
    //   codeSent: (String verificationId, int? resendToken) {
    //     int i = 0;
    //     _verificationId = verificationId;
    //     _resendToken = resendToken;
    //     update(state: PhoneVerificationState.inputCode);
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //     _verificationId = verificationId;
    //     update(state: PhoneVerificationState.timeout);
    //   },
    // );
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

  _handleError(FirebaseAuthException exception) async* {
    if (exception.code == "too-many-requests") {
      return;
    }

    if ((exception).code == "session-expired") {
      return;
    }
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
