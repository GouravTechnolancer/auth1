import 'package:auth/UI/menu.dart';
import 'package:auth/UI/profile.dart';
import 'package:auth/variable.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _screen =[
    const Center(child: Text('Dashboard'),),
    const Menu(),
    const Profile()
  ];
  int _currentIndex =0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: _screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: appbar,
        elevation: 0,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: 'Dashboard',),
          BottomNavigationBarItem(icon: Icon(Icons.menu),label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Profile')
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.black,
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
      //     child: GNav(
      //       backgroundColor: Colors.black,
      //       color: Colors.white,
      //       activeColor: Colors.white,
      //       tabBackgroundColor: Colors.grey.shade800,
      //       selectedIndex: _currentIndex,
      //       padding: EdgeInsets.all(10),
      //       tabs: [
      //         GButton(icon: Icons.dashboard,text: 'Dashboard',),
      //         GButton(icon: Icons.menu,text: 'Menu',),
      //         GButton(icon: Icons.person,text: 'Profile',),
      //       ],
      //       onTabChange: (index){
      //         setState(() {
      //           _currentIndex = index;
      //           print(_currentIndex);
      //         });
      //       },
      //     ),
      //   ),
      // ),
    );

  }


}


