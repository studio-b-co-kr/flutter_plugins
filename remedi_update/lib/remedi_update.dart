library remedi_update;
export 'package:remedi_update/feature/force_update_page.dart';
export 'package:remedi_update/repository/i_force_update_repository.dart';
export 'package:remedi_update/viewmodel/i_force_update_viewmodel.dart';

class ForceUpdate {
  static String _image;
  static String _iosAppId;
  static String _aosAppId;

  static String get image => _image;

  static String get iosAppId => _iosAppId;

  static String get aosAppId => _aosAppId;

  static init({String image, String iosAppId, String aosAppId}) {
    assert(iosAppId != null);
    assert(aosAppId != null);
    ForceUpdate._image = image;
    ForceUpdate._iosAppId = iosAppId;
    ForceUpdate._aosAppId = aosAppId;
  }
}
