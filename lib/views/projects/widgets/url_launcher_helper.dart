import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static Future<void> launchURL(String url, {String? errorMessage}) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint(errorMessage ?? 'Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  static Future<void> launchGitHub(String username) async {
    await launchURL(
      'https://github.com/$username',
      errorMessage: 'Could not launch GitHub profile',
    );
  }

  static Future<void> launchLinkedIn(String username) async {
    await launchURL(
      'https://linkedin.com/in/$username',
      errorMessage: 'Could not launch LinkedIn profile',
    );
  }

  static Future<void> launchEmail(String email, {String? subject, String? body}) async {
    String emailUrl = 'mailto:$email';
    if (subject != null || body != null) {
      emailUrl += '?';
      if (subject != null) emailUrl += 'subject=${Uri.encodeComponent(subject)}';
      if (body != null) {
        if (subject != null) emailUrl += '&';
        emailUrl += 'body=${Uri.encodeComponent(body)}';
      }
    }
    await launchURL(emailUrl, errorMessage: 'Could not launch email client');
  }

  static Future<void> launchPhone(String phoneNumber) async {
    await launchURL(
      'tel:$phoneNumber',
      errorMessage: 'Could not launch phone dialer',
    );
  }

  static Future<void> launchWebsite(String website) async {
    String url = website;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    await launchURL(url, errorMessage: 'Could not launch website');
  }
}