import 'package:firebase_auth/firebase_auth.dart';
import 'package:remedi_auth/repository/i_phone_verification_repository.dart';
import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';

class PhoneVerificationRepository extends IPhoneVerificationRepository {
  static final PhoneVerificationRepository _instance =
      PhoneVerificationRepository._();

  PhoneVerificationRepository._();

  factory PhoneVerificationRepository.instance() => _instance;

  Future<dynamic> verifyPhoneNumber(String phoneNumber,
      Function(PhoneVerificationState state)? onStateChanged) async {
    return await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: 'phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) {
        if (onStateChanged != null)
          onStateChanged(PhoneVerificationState.verified);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (onStateChanged != null)
          onStateChanged(PhoneVerificationState.error);
      },
      codeSent: (String verificationId, int? resendToken) {
        if (onStateChanged != null)
          onStateChanged(PhoneVerificationState.verifying);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (onStateChanged != null)
          onStateChanged(PhoneVerificationState.error);
      },
    );
  }
}

// enum PhoneVerificationState { completed, failed, codeSent, timeout }
