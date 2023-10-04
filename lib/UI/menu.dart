import 'package:auth/UI/manage_users.dart';
import 'package:auth/variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu'),
      centerTitle: true,
      backgroundColor: appbar,
      elevation: 0,),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      child: Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          Image(image: AssetImage('assets/management.png'),),
                          Text('ManageUsers')
                        ],
                      )
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, 'manageUsers');
                      },
                    ),
                  )),
            ],
          ),

        ],
      ),
    );
  }
}
