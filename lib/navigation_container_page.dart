import 'package:flutter/material.dart';
import 'package:minerz/pages/btc_learning.dart';
import 'package:minerz/pages/home.dart';
import 'package:minerz/pages/mine.dart';
import 'package:minerz/pages/referal.dart';

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const MiningScreen(),
    const ReferralScreen(),
    const BitcoinLearningScreen()
  ];

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);
    return SafeArea(
      bottom: false,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.black,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.orange,
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            _buildNavigationDestination(Icons.paid, Icons.paid_outlined),
            _buildNavigationDestination(Icons.construction, Icons.construction_outlined),
            _buildNavigationDestination(Icons.group_add, Icons.group_add_rounded),
            _buildNavigationDestination(Icons.school, Icons.school_outlined),
          ],
        ),
        body: pages[currentPageIndex],
      ),
    );
  }

  NavigationDestination _buildNavigationDestination(
    IconData selected,
    IconData unselected,
  ) {
    return NavigationDestination(
      selectedIcon: Icon(selected, color: Colors.black),
      icon: Icon(unselected, color: Colors.white),
      label: "",
    );
  }
}

/**
 * <Widget>[
          /// Notifications page
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    leading: Icon(Icons.notifications_sharp),
                    title: Text('Notification 1'),
                    subtitle: Text('This is a notification'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.notifications_sharp),
                    title: Text('Notification 2'),
                    subtitle: Text('This is a notification'),
                  ),
                ),
              ],
            ),
          ),

          /// Home page
          Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: SizedBox.expand(
              child: Center(
                child: Text(
                  'Home page',
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
          ),
      
          /// Messages page
          ListView.builder(
            reverse: true,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Hello',
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: theme.colorScheme.onPrimary),
                    ),
                  ),
                );
              }
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hi!',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            },
          ),
        ]
 */