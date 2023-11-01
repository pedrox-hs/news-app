import 'package:navigation/navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlNavigation extends IUrlNavigation {
  @override
  Future<void> open(String url) async {
    await launchUrl(Uri.parse(url));
  }
}