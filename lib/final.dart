import 'package:flutter/material.dart';

class FinalResonse extends StatelessWidget {
  const FinalResonse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Container(
  margin: const EdgeInsets.only(top: 380),
  child: Column(
    children: [
      const Text('Thankyou for reaching out! We will ask your views via email.', style: TextStyle(fontSize: 25),),
      ElevatedButton(onPressed: (){
        Navigator.pop(context);

      }, child: const Text('Get Back Home'))

    ],
  ),
)
    );
  }
}