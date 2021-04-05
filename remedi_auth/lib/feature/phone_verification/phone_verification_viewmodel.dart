import 'package:remedi_auth/repository/i_phone_verification_repository.dart';
import 'package:remedi_auth/viewmodel/i_phone_verification_viewmodel.dart';

class PhoneVerificationViewModel extends IPhoneVerificationViewModel {
  PhoneVerificationViewModel({required IPhoneVerificationRepository repository})
      : super(repository: repository);

  @override
  PhoneVerificationViewState get initState => PhoneVerificationViewState.Init;
}
