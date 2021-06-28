import 'dart:async';
import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:remedi_auth/repository/i_phone_verification_repository.dart';
import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';

import 'phone_verification_repository.dart';

class PhoneVerificationViewModel extends IPhoneVerificationViewModel {
  static const int _timeOut = 120;
  String? phoneNumber;
  int _remains = _timeOut;
  String? code = "";
  String? _verificationId;
  Timer? _timer;
  FirebaseAuth _auth = FirebaseAuth.instance;

  PhoneAuthCredential? phoneAuthCredential;
  String? errorMessage;

  startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (_remains == 0) {
        timer.cancel();
        update(state: PhoneVerificationState.expired);
      } else {
        _remains -= 1;
      }
      update(state: PhoneVerificationState.expired);
    });
  }

  requestVerify() async {
    dev.log("[requestVerify#1] state = $state", name: "PhoneVerification");
    _timer?.cancel();
    _remains = _timeOut;
    startTimer();
    dev.log(
        "[requestVerify#2] state = $state, forceResendingToken = $forceResendingToken",
        name: "PhoneVerification");
    await _auth.verifyPhoneNumber(
      forceResendingToken: forceResendingToken,
      timeout: Duration(seconds: _timeOut),
      phoneNumber: _phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // for android auto detecting sms
        dev.log(
            "[requestVerify#3] verificationCompleted, credential = $credential",
            name: "PhoneVerification");
        code = credential.smsCode;
        verifyCode(credential: credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        dev.log("[requestVerify#4] verificationFailed, e = $e",
            name: "PhoneVerification");
        if (e.code == "too-many-requests") {
          errorMessage = "30분 정도 후 다시 시도해주세요.";
        } else {
          errorMessage = null;
        }
        update(state: PhoneVerificationState.error);
      },
      codeSent: (String verificationId, int? resendToken) async {
        dev.log(
            "[requestVerify#5] codeSent, verificationId = $verificationId, resendToken = $resendToken",
            name: "PhoneVerification");
        if (resendToken != null) {}
        _verificationId = verificationId;
        update(state: PhoneVerificationState.sent);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        dev.log(
            "[requestVerify#6] codeAutoRetrievalTimeout, verificationId = $verificationId",
            name: "PhoneVerification");
        _verificationId = verificationId;
        update(state: PhoneVerificationState.expired);
      },
    );
  }

  verifyCode({PhoneAuthCredential? credential, String? code}) async {
    dev.log("[verifyCode#1] state = $state", name: "PhoneVerification");
    update(state: PhoneVerificationState.verifying);
    if (credential == null) {
      try {
        phoneAuthCredential = PhoneAuthProvider.credential(
            verificationId: _verificationId!, smsCode: code!);
      } catch (e) {
        dev.log("[verifyCode#2] state = $state", name: "PhoneVerification");
        update(state: PhoneVerificationState.error);
        return;
      }
    } else {
      phoneAuthCredential = credential;
    }

    bool ret = false;
    String? errorCode;
    try {
      await _auth.signInWithCredential(phoneAuthCredential!);
      // await UserRepository.instance.deletePhoneVerificationResendToken();
      _auth.signOut();
      ret = true;
    } catch (e) {
      ret = false;
      if (e is FirebaseAuthException) {
        errorCode = e.code;
      }
    }

    if (ret) {
      dev.log("[verifyCode#3] state = $state", name: "PhoneVerification");
      return;
    }

    dev.log("[verifyCode#4] state = $state, errorCode = $errorCode",
        name: "PhoneVerification");
    switch (errorCode) {
      case "session-expired":
        dev.log("[verifyCode#5] state = $state", name: "PhoneVerification");
        update(state: PhoneVerificationState.expired);
        break;
      default:
        update(state: PhoneVerificationState.error);
        break;
    }
  }

  get remainsString {
    String min = "0${_remains ~/ 60}";
    int intSec = _remains % 60;
    String sec = intSec < 10 ? "0${_remains % 60}" : "${_remains % 60}";
    return "$min:$sec";
  }

  get _phoneNumber {
    String ret =
        "+82${phoneNumber?.replaceAll(new RegExp("-"), "").substring(1)}";
    return ret;
  }

  @override
  IPhoneVerificationRepository get repository =>
      PhoneVerificationRepository.instance();

  @override
  PhoneVerificationState get initState => PhoneVerificationState.init;

  @override
  int? get forceResendingToken => throw UnimplementedError();
}
