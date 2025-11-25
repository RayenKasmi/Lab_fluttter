import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback toggleNavigation;

  const CustomDrawer({
    super.key,
    required this.toggleNavigation,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue, // background color
            ),
            margin: EdgeInsets.zero,  // remove default margin
            padding: EdgeInsets.zero, // remove default padding
            child: Image.asset(
              "assets/images/insat.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.tab),
            title: const Text("Toggle navigation"),
            onTap: () {
              Navigator.pop(context);        // Close drawer
              toggleNavigation();            // Notify parent
            },
          )
        ],
      ),
    );
  }
}
