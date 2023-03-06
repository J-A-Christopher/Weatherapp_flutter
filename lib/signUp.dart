import 'package:flutter/material.dart';
import './signIn.dart';
import './rgex/file.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController p1 = TextEditingController();
    TextEditingController p2 = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact us!'),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * .30,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(220))),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Talk to our team ! ',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 60,
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Have any problems or any preference concerning our news ?;\n Fill out the form and we will be in touch shortly.',
                    style: TextStyle(fontSize: 17),
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 8,
            color: Colors.lightGreen,
            child: Container(
                height: 460,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Get Started...',
                        style:
                            TextStyle(color: Color(0xff1034A6), fontSize: 30),
                      ),

                      TextFormField(
                        validator: (value) {
                          if (!value!.isValidName) {
                            return 'Please Enter a Valid Name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Name',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),

                      TextFormField(
                        validator: (value) {
                          if (!value!.isValidEmail) {
                            return 'Please Enter a Valid Email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: p1,
                        validator: (value) {
                          if (!value!.isValidPassword) {
                            return 'Password Must Contain 6-20chars, atleast one digit & one letter';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.key_rounded),
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: p2,
                        validator: (_) {
                          if (p1.text != p2.text) {
                            return 'Passwords do not match!!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Confirm Password',
                          prefixIcon: Icon(Icons.key_rounded),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const SignIn()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: const StadiumBorder()),
                        child: const Text('Create User'),
                      ),

                      //  Checkbox(value: checkBoxValue, onChanged: (bool?newValue){setState((){checkBoxValue = newValue!;});})
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Already Have An Account?'),
                          FloatingActionButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignIn()));
                            },
                            child: const Icon(Icons.arrow_forward),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
