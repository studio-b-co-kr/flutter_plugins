bool _enableGoogleAnalytics = false;
bool _enableRemediAnalytics = false;

class RemediAnalytics {
  static init({
    bool enableGoogleAnalytics = false,
    bool enableRemediAnalytics = false,
  }) {
    _enableGoogleAnalytics = enableGoogleAnalytics;
    _enableRemediAnalytics = enableRemediAnalytics;
  }
}
