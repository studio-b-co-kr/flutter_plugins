import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:remedi_auth/model/phone_verification.dart';
import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';

class PhoneVerificationViewModel extends IPhoneVerificationViewModel {
  int? _resendToken;
  String? _verificationId;

  @override
  PhoneVerificationState get initState =>
      PhoneVerificationState.inputPhoneNumber;

  @override
  requestVerify() async {
    PhoneAuthCredential credential = await PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: phoneVerification.verificationCode,
    );
    UserCredential userCredential;
    try {
      userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      _handleError(e as FirebaseAuthException);
      return;
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
      phoneVerification.phoneNumber = phoneNumber.phoneNumber!;
      phoneVerification.verificationCode = code;
      update(state: PhoneVerificationState.readyToVerify);
      requestVerify();
    } else if (_prevCode?.length == 6 && code.length != 6) {
      update(state: PhoneVerificationState.inputCode);
    }
    _prevCode = code;
  }

  @override
  requestSendCode() {
    update(state:PhoneVerificationState.requestingSendCode);
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber.phoneNumber!,
      timeout: Duration(minutes: 3),
      forceResendingToken: _resendToken,
      verificationCompleted: (PhoneAuthCredential credential) {
        update(state: PhoneVerificationState.verified);
      },
      verificationFailed: (FirebaseAuthException e) {
        update(state: PhoneVerificationState.errorOnRequest);
      },
      codeSent: (String verificationId, int? resendToken) {
        int i = 0;
        _verificationId = verificationId;
        _resendToken = resendToken;
        update(state: PhoneVerificationState.inputCode);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        update(state: PhoneVerificationState.timeout);
      },
    );
  }

  @override
  changePhoneNumber() {
    _reset();
    update(state: PhoneVerificationState.inputPhoneNumber);
  }

  _reset() {
    phoneNumber = PhoneNumber();
    phoneVerification = PhoneVerification();
  }

  _handleError(FirebaseAuthException exception) async* {
    if (exception.code == "too-many-requests") {
      return;
    }

    if ((exception).code == "session-expired") {
      return;
    }
  }
}
