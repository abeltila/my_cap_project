part of 'index.dart';

//URL launcher service to show external links
class UrlLauncherService {
  Future<void> launchURL(String url) async {
    //pares url String to URI
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      return;
    }
  }
}
