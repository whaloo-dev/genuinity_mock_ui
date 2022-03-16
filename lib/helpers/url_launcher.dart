import 'package:url_launcher/url_launcher.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

goToShopify() {
  launchURL("https://${storeController.store!.id}.myshopify.com/admin/");
}
