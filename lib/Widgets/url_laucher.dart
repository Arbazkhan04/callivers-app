
import 'package:calliverse/Widgets/toast.dart';
import 'package:url_launcher/url_launcher.dart';


launchURL({url,LaunchMode? launchMode}) async {

  if (await canLaunch(url)) {
    await launchUrl(Uri.parse(url),mode: launchMode?? LaunchMode.inAppWebView);
  } else {
    // Print the detailed error message
    try {
      await launchUrl(Uri.parse(url),mode: launchMode?? LaunchMode.inAppWebView,);

    } catch (e) {
      print('Error launching $url: $e');
    AppToast.show("Could not launch $url");
    }
  }
}