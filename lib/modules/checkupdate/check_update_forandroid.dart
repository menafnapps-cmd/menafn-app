import 'package:flutter/material.dart';
import 'package:menafn/modules/bottomnav/bottomnav.dart';
import 'package:url_launcher/url_launcher.dart';

class update extends StatefulWidget {
  _update createState() => _update();
}
class _update extends State<update> {
  @override
  void initState() {
    super.initState();
    checkVersion();
  }

  Future<void> checkVersion() async {
    int statusCode = 200;
    int localVersion = 10;
    int serverLatestVersion = 10;

    Future.delayed(Duration.zero, () {
      if (statusCode == 412) {
        _showUpdateDialog(
          forceUpdate: true,
          message:
          'Your app requires you to update to the latest version. You cannot use this app until it is updated.',
          updateButtonLabel: 'Upgrade',
          closeButtonLabel: 'Exit',
          appStoreUrl: 'https://apps.apple.com/sa/app/menafn/id1255148674?l',
          playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.menafn2024.menafn2024',
        );
      } else if (serverLatestVersion > localVersion) {
        _showUpdateDialog(
          forceUpdate: false,
          message:
          'A new version of the app is available. Would you like to update now?',
          updateButtonLabel: 'Upgrade',
          ignoreButtonLabel: 'Next Time',
          appStoreUrl: 'https://apps.apple.com/sa/app/menafn/id1255148674?l',
          playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.menafn2024.menafn2024',
        );
      }
    });
  }

  void _showUpdateDialog({
     required bool forceUpdate,
     required String message,
     required String updateButtonLabel,
     String? closeButtonLabel,
     String? ignoreButtonLabel,
     required String appStoreUrl,
     required String playStoreUrl,
  }) {
    showDialog(
      context: context,
      barrierDismissible: !forceUpdate,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Available'),
          content: Text(message),
          actions: <Widget>[
            if (!forceUpdate && ignoreButtonLabel != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text(ignoreButtonLabel),
              ),
            TextButton(
              onPressed: () {
                _launchStoreUrl(appStoreUrl, playStoreUrl);
              },
              child: Text(updateButtonLabel),
            ),
            if (forceUpdate && closeButtonLabel != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Exit the app
                },
                child: Text(closeButtonLabel),
              ),
          ],
        );
      },
    );
  }

  Future<void> _launchStoreUrl(String appStoreUrl, String playStoreUrl) async {
    final String url = Theme.of(context).platform == TargetPlatform.iOS
        ? appStoreUrl
        : playStoreUrl;

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return bottomNav();
  }
}
