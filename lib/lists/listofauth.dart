import 'package:flutter/material.dart';

class ListOfAuth extends StatefulWidget {
  const ListOfAuth({super.key});

  @override
  State<ListOfAuth> createState() => _ListOfAuthState();
}

class _ListOfAuthState extends State<ListOfAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authentication'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mail,size: 45),
              OutlinedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "signin");
                  },
                  child: Text('Email Login'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone,size: 45),
              OutlinedButton(
                  onPressed: (){
                    print("not linked yet");
                  },
                  child: Text('Phone Login'))
            ],
          ),

        ],
      ),
    );
  }
}
