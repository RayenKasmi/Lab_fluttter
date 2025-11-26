import 'package:flutter/material.dart';
import 'package:tp0/common/custom_drawer.dart';
import 'package:tp0/common/tab_bar.dart';
import 'package:tp0/widgets/basket.dart';
import 'package:tp0/widgets/singup_form_widget.dart';
import '../widgets/book_slide.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key, required this.title, required this.onToggleTheme});

  final String title;
  final VoidCallback onToggleTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool navigationToggle = true;

  @override
  Widget build(BuildContext context){
    
    final List<Widget> screens = [
      BookSlide(title: widget.title),
      SingupFormWidget(),
      BasketScreen(),
    ];
    return Scaffold(
      drawer: CustomDrawer(toggleNavigation: () => setState(() { navigationToggle = !navigationToggle; })
      ),
      appBar: AppBar(
        title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ) ,
          ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 34, 99, 238),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme, // toggle theme
          )
        ],
      ),
      body: navigationToggle ? 
      MyTabBar(title: widget.title) :
      screens[_currentIndex],
      bottomNavigationBar: navigationToggle ?
      null
      :BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Catalogue'),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Signup'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Basket'),

        ],
      ),
    );
    //return MyTabBar(title: widget.title);
  }
}