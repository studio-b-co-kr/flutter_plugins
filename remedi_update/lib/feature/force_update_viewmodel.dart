import 'package:remedi_update/remedi_update.dart';
import 'package:store_redirect/store_redirect.dart';

class ForceUpdateViewModel extends IForceUpdateViewModel {
  ForceUpdateViewModel({required IForceUpdateRepository repository})
      : super(repository: repository);

  @override
  goToUpdate() {
    StoreRedirect.redirect(
      androidAppId: repository.androidAppId,
      iOSAppId: repository.iosAppId,
    );
  }
}
