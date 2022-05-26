part of 'architecture.dart';

/// [AppModel] MaterialApp 보다 상위의 Widget Tree 의 최상위에 존재한다.
/// [AppModel] 은 앱 전체가 공유해야하는 데이터와 비즈니스 로직을 제공한다.
/// ex>. theme, locale, network status 등의 전역 데이터,
/// [withInit] 초기화 과정이 필요한 경우 'true' 로 한다.
/// 만약 코드상 사용하는 곳이 없는 경우 (Provider.of(context) 로 접근),
/// 인스턴스가 만들어지지 않기 때문에 초기화 과정을 거치치 않는다.
abstract class AppModel with ChangeNotifier implements ReassembleHandler {
  bool _initialised = false;

  List<Future> initialJob() {
    return [];
  }

  initialise() async {
    if (_initialised) {
      return;
    }

    AppLog.log('initialised', name: toString());
    await Future.wait(initialJob());

    _initialised = true;
  }

  @override
  void reassemble() {
    onHotRefresh();
  }

  /// HotReload 혹은 HotRestart 시에 콜된다.
  void onHotRefresh() {
    AppLog.log('onHotRefresh', name: toString());
  }

  @override
  void dispose() {
    _initialised = false;
    super.dispose();
  }

  @override
  String toString() {
    return '${super.toString()}.$hashCode';
  }
}
