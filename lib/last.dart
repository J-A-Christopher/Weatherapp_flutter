import 'package:flutter/material.dart';

class LastPage extends StatelessWidget {
  const LastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color(0xFF07060d),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 300),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                Icon(Icons.signal_wifi_connected_no_internet_4_rounded, color: Colors.white,size: 50,),
                Text('No Internet Connection !', style: TextStyle(color: Colors.white,fontSize: 25),)

                          ],
                        ),
          ),

        ],
      ),

    );
  }
}