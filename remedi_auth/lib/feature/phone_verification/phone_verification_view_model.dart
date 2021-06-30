import 'package:remedi_auth/feature/phone_verification/phone_verification_repository.dart';
import 'package:remedi_auth/feature/phone_verification/phone_verification_view.dart';
import 'package:remedi_auth/repository/i_phone_verification_repository.dart';
import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';

class PhoneVerificationViewModel extends IPhoneVerificationViewModel {
  bool _showRequestButton = false;

  @override
  int? get forceResendingToken => null;

  @override
  PhoneVerificationState get initState =>
      PhoneVerificationState.inputPhoneNumber;

  @override
  IPhoneVerificationRepository get repository =>
      PhoneVerificationRepository.instance();

  @override
  bool get showRequestButton => _showRequestButton;

  changePhoneNumber() {
    update();
  }
}
