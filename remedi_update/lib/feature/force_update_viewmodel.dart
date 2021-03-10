import 'package:remedi_update/remedi_update.dart';
import 'package:store_redirect/store_redirect.dart';

class ForceUpdateViewModel extends IForceUpdateViewModel {
  IForceUpdateRepository repo;

  ForceUpdateViewModel({this.repo}) : assert(repo != null);

  @override
  goToUpdate() {
    StoreRedirect.redirect(
      androidAppId: repository.androidAppId,
      iOSAppId: repository.iosAppId,
    );
  }

  @override
  // TODO: implement initState
  ForceUpdateViewState get initState => ForceUpdateViewState.Init;

  @override
  IForceUpdateRepository get repository => repo;
}
