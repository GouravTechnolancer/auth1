import 'package:auth/UI/manage_projects.dart';
import 'package:auth/variable.dart';
import 'package:flutter/material.dart';

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
              Expanded(flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      child: const Card(
                      elevation: 5,
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          Image(image: AssetImage('assets/management.png'),),
                          Text('Manage Users')
                        ],
                      )
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, 'manageUsers');
                      },
                    ),
                  )),
              Expanded(
                flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      child: const Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              SizedBox(height: 5,),
                              Image(image: AssetImage('assets/manageuser.png'),),
                              Text('Manage Customers')
                            ],
                          )
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, 'manageCustomer');
                      },
                    ),
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      child: const Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              SizedBox(height: 5,),
                              Image(image: AssetImage('assets/project.png')),
                              Text('Manage Projects')
                            ],
                          )
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> ManageProjects()));
                      },
                    ),
                  )),
              Expanded(
                flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      child: const Card(
                          elevation: 5,
                          child: Column(
                            children: [
                              SizedBox(height: 5,),
                              Image(image: AssetImage('assets/order-fulfillment.png'),),
                              Text('Manage Payments')
                            ],
                          )
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, '');
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
