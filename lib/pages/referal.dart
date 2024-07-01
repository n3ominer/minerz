import 'package:flutter/material.dart';
import 'package:minerz/models/referal/referal_task.dart';
import 'package:minerz/widgets/referal_task.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 16.0),
      //       child: Container(
      //         height: 35.0,
      //         width: 35.0,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(30),
      //           border: Border.all(width: 1.0, color: Colors.white),
      //         ),
      //         child: const Icon(
      //           Icons.more_vert,
      //           color: Colors.white,
      //           size: 20,
      //         ),
      //       ),
      //     ),
      //   ],
      //   title: const Text(
      //     "Refferal & earn",
      //     style: TextStyle(
      //       color: Colors.orange,
      //       fontSize: 20.0,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.black,
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: SizedBox(
              height: 200.0,
              width: 200.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "images/satoshi_referal.jpeg",
                  cacheHeight: 500,
                  cacheWidth: 500,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const Center(
            child: Text(
              "Earn",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                fontFamily: "BungeeSpice",
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          _buildTasksSection(
            true,
            inviteTasks,
            () {},
            sectionTitle: "Invite tasks",
          ),
          const SizedBox(
            height: 16,
          ),
          _buildTasksSection(
            true,
            dailyTasks,
            () {},
            sectionTitle: "Daily tasks",
            hasEarnings: false,
          ),
          const SizedBox(
            height: 16,
          ),
          _buildTasksSection(
            true,
            specialTasks,
            () {},
            sectionTitle: "Special tasks",
          ),
          const SizedBox(
            height: 10,
          ),
          _buildTasksSection(
            true,
            bonusTasks,
            () {},
            sectionTitle: "Bonus",
          ),
        ],
      ),
    );
  }

  Padding _buildTasksSection(
      bool withSectionTitle, List<ReferalTasks> tasks, Function? onTapCallback,
      {String sectionTitle = "", bool hasEarnings = true}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          withSectionTitle
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    sectionTitle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : Container(),
          SizedBox(
            height: tasks.length * 90,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    print("Display task");
                    tasks[index].taskAction(context);
                  },
                  child: ReferalTasksCellWidget(
                    tasks: tasks,
                    taksIndex: index,
                    fontFamily: hasEarnings ? 'Rye' : '',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
