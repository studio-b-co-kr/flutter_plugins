import 'package:remedi_update/remedi_update.dart';
import 'package:store_redirect/store_redirect.dart';

class ForceUpdateViewModel extends IForceUpdateViewModel {
  ForceUpdateViewModel({IForceUpdateRepository repository})
      : super(repo: repository);

  @override
  goToUpdate() {
    StoreRedirect.redirect(
      androidAppId: repository.androidAppId,
      iOSAppId: repository.iosAppId,
    );
  }
}
