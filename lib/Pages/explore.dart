
import 'package:flutter/material.dart';
import 'package:qverbo/tabs/cottages.dart';
import 'package:qverbo/tabs/inns.dart';
import 'package:qverbo/tabs/transients.dart';

class explore extends StatefulWidget {
  const explore ({super.key});

  @override
  State<explore> createState() {
    return _exploreState();
  }
}

List<Widget> tabs = [TransientTab(), InnsTab(), CottageTab()];

class _exploreState extends State<explore> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your destination...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.search),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TabBar(
              tabs: [
                Tab(
                  text: 'Transients',
                  icon: Icon(Icons.hotel),
                ),
                Tab(text: 'Inns', icon: Icon(Icons.bed)),
                Tab(text: 'Cottages', icon: Icon(Icons.villa_rounded)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: tabs,
              ),
            )
          ],
        ),
      ),
    );
  }
}
