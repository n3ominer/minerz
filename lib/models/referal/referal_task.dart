class ReferalTasks {
  String taskIcon;
  String taskTitle;
  String taskDescription;
  Function taskAction;

  ReferalTasks({
    required this.taskIcon,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskAction,
  });
}

List<ReferalTasks> inviteTasks = List.from([
  ReferalTasks(
    taskIcon: "images/handshake.png",
    taskTitle: "Orange pill a fren",
    taskDescription:
        "30,000",
    taskAction: () {},
  ),
]);

List<ReferalTasks> dailyTasks = List.from([
  ReferalTasks(
    taskIcon: "images/calendar.png",
    taskTitle: "Free sats",
    taskDescription:
        "GM fren, free sats",
    taskAction: () {},
  ),
]);

List<ReferalTasks> specialTasks = List.from([
  ReferalTasks(
    taskIcon: "images/X.jpg",
    taskTitle: "Follow us on X",
    taskDescription:
        "10,000",
    taskAction: () {},
  ),
  ReferalTasks(
    taskIcon: "images/X.jpg",
    taskTitle: "Follow our founder on X",
    taskDescription:
        "10,000",
    taskAction: () {},
  ),
  ReferalTasks(
    taskIcon: "images/nostr.png",
    taskTitle: "Follow us on Nostr",
    taskDescription:
        "10,000",
    taskAction: () {},
  ),
  ReferalTasks(
    taskIcon: "images/btc_light.png",
    taskTitle: "Support the project",
    taskDescription:
        "100,000",
    taskAction: () {},
  ),
  ReferalTasks(
    taskIcon: "images/youtube.png",
    taskTitle: "Follow us on Youtube",
    taskDescription:
        "10,000",
    taskAction: () {},
  ),
  ReferalTasks(
    taskIcon: "images/bell.png",
    taskTitle: "Join our Telegram channel",
    taskDescription:
        "20,000",
    taskAction: () {},
  ),
]);

List<ReferalTasks> bonusTasks = List.from([
  ReferalTasks(
    taskIcon: "images/2fingz.png",
    taskTitle: "Invite 2 frens",
    taskDescription:
        "50,000",
    taskAction: () {},
  ),
  ReferalTasks(
    taskIcon: "images/5fingz.png",
    taskTitle: "Invite 5 frens",
    taskDescription:
        "150,000",
    taskAction: () {},
  ),
  ReferalTasks(
    taskIcon: "images/10fingz.png",
    taskTitle: "Invite 10 frens",
    taskDescription:
        "500,000",
    taskAction: () {},
  ),
  ReferalTasks(
    taskIcon: "images/alien.png",
    taskTitle: "Invite 100 frens",
    taskDescription:
        "5,000,000",
    taskAction: () {},
  ),
]);