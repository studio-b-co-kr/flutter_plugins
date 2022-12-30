import 'package:remedi_update/remedi_update.dart';

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
