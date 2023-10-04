import 'package:flutter/material.dart';

class WorkHubLogo extends StatefulWidget {
  const WorkHubLogo({super.key});

  @override
  State<WorkHubLogo> createState() => _WorkHubLogoState();
}


class _WorkHubLogoState extends State<WorkHubLogo> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, 'splash');
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(width: 4,color:Colors.white.withOpacity(0.4))
              ),
                child: const Image(
                    image: AssetImage('assets/work.png')
                ))
          ],
        ),
      ),
    );
  }
}
