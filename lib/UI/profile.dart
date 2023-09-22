import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title:const Text('Profile',
        style: TextStyle(color: Colors.black),),
        centerTitle: true,elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
          Navigator.pop(context);
        },),
        actions: const [
          Icon(Icons.notifications,color:Colors.black)
        ],
      ),

      body:ListView(
        children: [
          Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width:130,
                      height: 130,
                      decoration: BoxDecoration(
                          color:Colors.red,
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-'
                                '1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wx'
                                'MjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto'
                                '=format&fit=crop&w=1740&q=80'),
                            fit: BoxFit.cover

                          ),
                        border:Border.all(width:4,color: Colors.white),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 5,
                        child: Container(
                          width:40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade400,
                            border: Border.all(width:2,color: Colors.white)
                          ),
                          child: const Icon(Icons.edit),
                        )
                    )
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, 'home');
              },style: ElevatedButton.styleFrom(backgroundColor: const Color(0x0000000a)), child: const Text('Edit Profile'),),
              const SizedBox(height: 25,),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                           color: Colors.black,
                           borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.person,color:Colors.white),
                            SizedBox(width: 20,),
                            Text('Name',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: 220,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:   BorderRadius.circular(5),
                         color: Colors.grey,
                      ),
                      child: const Center(child: Text('Gourav', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                    ),
                  )

                ],
              ) ,
              const SizedBox(height:25 ,),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.edit,color: Colors.white,),
                            SizedBox(width: 20,),
                            Text('Age',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: 220,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:   BorderRadius.circular(5)   ,
                        color: Colors.grey,
                      ),
                      child: const Center(child: Text('23',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),)),
                    ),
                  )

                ],
              ) ,
              const SizedBox(height:25 ,),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.person,color: Colors.white,),
                            SizedBox(width: 20,),
                            Text('Gender',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: 220,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:   BorderRadius.circular(5)   ,
                        color: Colors.grey,
                      ),
                      child: const Center(child: Text('Male',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),)),
                    ),
                  )

                ],
              ) ,
              const SizedBox(height:25 ,),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.mail,color: Colors.white,),
                            SizedBox(width: 20,),
                            Text('Email',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: 220,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:   BorderRadius.circular(5)   ,
                        color: Colors.grey,
                      ),
                      child: const Center(child: Text('  gourav.technolancer@gmail.com  ', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),),
                    ),
                  )

                ],
              ) ,
              const SizedBox(height:25 ,),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.phone,color: Colors.white,),
                            SizedBox(width: 20,),
                            Text('Phone',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: 220,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:   BorderRadius.circular(5)   ,
                        color: Colors.grey,
                      ),
                      child: const Center(child: Text('7710567945',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),)),
                    ),
                  )

                ],
              ) ,
              const SizedBox(height:25 ,),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: SizedBox(
                      width: 150,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 20,),
                            Icon(Icons.calendar_month,color: Colors.white,),
                            SizedBox(width: 20,),
                            Text('D-O-B',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: 220,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:   BorderRadius.circular(5)   ,
                        color: Colors.grey,
                      ),
                      child: const Center(child: Text('20-20-0000',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),)),
                    ),
                  )

                ],
              ) ,
            ],
          ),
          const SizedBox(height: 10,),
          Column(
            children: [
              ElevatedButton(onPressed: (){
              },style: ElevatedButton.styleFrom(backgroundColor: const Color(0x0000000a)), child: const Text('Logout'),),
              Container(
                width: double.infinity,
                height: 15,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle
                ),
                child:const Center(child: Text('Term & Conditions',style: TextStyle(color: Colors.blue),),)
              ),
              Divider(thickness: 3,)
              ]),

            ],
          ),
      bottomNavigationBar: Row(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
            width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/messenger.png'),
            ),
          ) ,
          Container(
            margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
            width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/linkedin.png'),
            ),
          ) ,
          Container(
             margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
             width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/instagram.png'),
            ),
          ) ,
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.fromLTRB(30,  0, 0, 0),
           child: CircleAvatar(
             backgroundImage: AssetImage('assets/facebook.png'),
           ),
          ),




        ],
      )
    )
    );

  }
}

