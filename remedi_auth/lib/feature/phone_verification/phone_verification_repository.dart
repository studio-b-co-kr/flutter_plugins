import 'package:firebase_auth/firebase_auth.dart';
import 'package:remedi_auth/repository/i_phone_verification_repository.dart';

class PhoneVerificationRepository extends IPhoneVerificationRepository {
  Future<dynamic> verifyPhoneNumber(String phoneNumber,
      Function(PhoneVerificationState state)? onStateChanged) async {
    return await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: 'phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) {
        if (onStateChanged != null)
          onStateChanged(PhoneVerificationState.completed);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (onStateChanged != null)
          onStateChanged(PhoneVerificationState.failed);
      },
      codeSent: (String verificationId, int? resendToken) {
        if (onStateChanged != null)
          onStateChanged(PhoneVerificationState.codeSent);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (onStateChanged != null)
          onStateChanged(PhoneVerificationState.timeout);
      },
    );
  }
}

enum PhoneVerificationState { completed, failed, codeSent, timeout }
