import 'package:flutter/material.dart';
import 'package:minerz/widgets/support_qr_code.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class ReferalTasks {
  String taskIcon;
  String taskTitle;
  String taskDescription;
  Function(BuildContext) taskAction;

  ReferalTasks({
    required this.taskIcon,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskAction,
  });
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

void _inviteFriends() async {
  final result = await Share.shareWithResult(
      'Join me on Minerz App, the first Tap 2 Learn bitcoin app. Upgrade your cards, learn about bitcoin history, have fun and take the orange pill 💊⚡️!',
      subject: '#Tap2Learn Bitcoin !');

  if (result.status == ShareResultStatus.success) {
    // Give the coins here
    print('Thank you for sharing my website!');
  }
}

List<ReferalTasks> inviteTasks = List.from([
  ReferalTasks(
    taskIcon: "images/handshake.png",
    taskTitle: "Orange pill a fren",
    taskDescription: "30,000",
    taskAction: (context) {
      _inviteFriends();
    },
  ),
]);

List<ReferalTasks> dailyTasks = List.from([
  ReferalTasks(
    taskIcon: "images/calendar.png",
    taskTitle: "Free sats",
    taskDescription: "GM fren, free sats",
    taskAction: (context) {},
  ),
]);

List<ReferalTasks> specialTasks = List.from([
  ReferalTasks(
    taskIcon: "images/X.jpg",
    taskTitle: "Follow us on X",
    taskDescription: "10,000",
    taskAction: (context) {},
  ),
  ReferalTasks(
    taskIcon: "images/X.jpg",
    taskTitle: "Follow our founder on X",
    taskDescription: "10,000",
    taskAction: (context) {
      _launchUrl("https://x.com/elprofessorsat");
    },
  ),
  ReferalTasks(
    taskIcon: "images/nostr.png",
    taskTitle: "Follow us on Nostr",
    taskDescription: "10,000",
    taskAction: (context) {
      _launchUrl(
          "https://primal.net/p/npub1yeutujy89h37a9w7k997e3yw2ad53nd37rpkkdkpzqrrku0q6a5q5hk3y6");
    },
  ),
  ReferalTasks(
    taskIcon: "images/btc_light.png",
    taskTitle: "Support the project",
    taskDescription: "100,000",
    taskAction: (context) {
      //_launchUrl("https://elprofessor.com");
      showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.black,
        builder: (BuildContext context) {
          return const SUpportQrCodeWidget();
        },
      );
    },
  ),
  ReferalTasks(
    taskIcon: "images/youtube.png",
    taskTitle: "Follow us on Youtube",
    taskDescription: "10,000",
    taskAction: (context) {},
  ),
  ReferalTasks(
    taskIcon: "images/bell.png",
    taskTitle: "Join our Telegram channel",
    taskDescription: "20,000",
    taskAction: (context) {
      _launchUrl("https://t.me/minerzApp");
    },
  ),
]);

List<ReferalTasks> bonusTasks = List.from([
  ReferalTasks(
    taskIcon: "images/2fingz.png",
    taskTitle: "Invite 2 frens",
    taskDescription: "50,000",
    taskAction: (context) {
      _inviteFriends();
    },
  ),
  ReferalTasks(
    taskIcon: "images/5fingz.png",
    taskTitle: "Invite 5 frens",
    taskDescription: "150,000",
    taskAction: (context) {
      _inviteFriends();
    },
  ),
  ReferalTasks(
    taskIcon: "images/10fingz.png",
    taskTitle: "Invite 10 frens",
    taskDescription: "500,000",
    taskAction: (context) {
      _inviteFriends();
    },
  ),
  ReferalTasks(
    taskIcon: "images/alien.png",
    taskTitle: "Invite 100 frens",
    taskDescription: "5,000,000",
    taskAction: (context) {
      _inviteFriends();
    },
  ),
]);
