import 'package:remedi_update/remedi_update.dart';
import 'package:store_redirect/store_redirect.dart';

class ForceUpdateViewModel extends IForceUpdateViewModel {
  final IForceUpdateRepository repository;

  ForceUpdateViewModel({required this.repository}) : super();

  @override
  goToUpdate() {
    StoreRedirect.redirect(
      androidAppId: repository.androidAppId,
      iOSAppId: repository.iosAppId,
    );
  }

  @override
  ForceUpdateViewState get initState => ForceUpdateViewState.Init;
}
