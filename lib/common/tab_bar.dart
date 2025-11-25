

import 'package:flutter/material.dart';
import 'package:tp0/widgets/book_slide.dart';
import 'package:tp0/widgets/singup_form_widget.dart';

class MyTabBar extends StatefulWidget {
  final String title;

  const MyTabBar({super.key, required this.title});

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  late TabController tabController;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      BookSlide(title: widget.title),
      SingupFormWidget(),
    ];
    tabController = TabController(length: pages.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color.fromARGB(255, 34, 99, 238),
          child: TabBar(
            controller: tabController,
            labelColor: Colors.white,
            tabs: const [
              Tab(icon: Icon(Icons.home_outlined), text: "Home"),
              Tab(icon: Icon(Icons.login), text: "Signup"),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: pages,
          ),
        ),
      ],
    );
  }
}
