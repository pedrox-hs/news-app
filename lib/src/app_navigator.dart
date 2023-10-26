import 'package:navigation/navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class AppNavigator extends IAppNavigator {
  @override
  Future<void> openUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }
}