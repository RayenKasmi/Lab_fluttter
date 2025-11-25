import 'package:flutter/material.dart';
import 'package:tp0/widgets/singup_form_widget.dart';
import '../widgets/book_slide.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current_index = 0;

  @override
  Widget build(BuildContext context){
    final List<Widget> screens = [
      BookSlide(title: widget.title),
      SingupFormWidget(),
    ];
    return Scaffold(
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
      ),
      body: screens[_current_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _current_index,
        onTap: (index) {
          setState(() {
            _current_index = index;
          });
        },
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Catalogue'),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Signup'),
        ],
      ),
    );
  }
}