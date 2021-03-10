import 'package:remedi_update/repository/i_force_update_repository.dart';
import 'package:stacked_mvvm/stacked_mvvm.dart';
import 'package:store_redirect/store_redirect.dart';

abstract class IForceUpdateViewModel
    extends BaseViewModel<ForceUpdateViewState, IForceUpdateRepository> {
  final String iosAppId;
  final String aosAppId;

  IForceUpdateViewModel({this.iosAppId, this.aosAppId})
      : assert(iosAppId != null),
        assert(aosAppId != null);

  goToUpdate() {
    StoreRedirect.redirect(
      androidAppId: aosAppId,
      iOSAppId: iosAppId,
    );
  }
}

enum ForceUpdateViewState { Init }
