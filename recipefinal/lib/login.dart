//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:recipefinal/signup.dart';
//import 'package:recipefinal/spoon/searchPage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipefinal/signup.dart';
import 'package:recipefinal/spoon/searchPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool togglepassword = true;

  login(String myemail, String mypassword) async {
    if (myemail == "" && mypassword == "") {
      return await showDialog(
          context: context,
          builder: (context) {
            return Container(
              child: AlertDialog(
                title: const Text("Enter Required Fields"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"))
                ],
              ),
            );
          });
    } else {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) {
          if (myemail == "sh@gmail.com" && mypassword == "123456") {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SearchPage()));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SearchPage()));
          }
        });
      } on FirebaseAuthException catch (ex) {
        return await showDialog(
            context: context,
            builder: (context) {
              return Container(
                child: AlertDialog(
                  title: Text("${ex.code.toString()}"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"))
                  ],
                ),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        // Colors.deepOrange[300],
        image: DecorationImage(
          image: const AssetImage("assets/images/recipe.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              const Color.fromARGB(255, 33, 33, 33).withOpacity(0.2),
              BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 80, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.dinner_dining,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "R E C I P E",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 300,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 32,
                  fontWeight: FontWeight.w500),
            ),
            _buildGreyText("Please login with your information"),
            const SizedBox(height: 40),
            _buildGreyText("Email address"),
            _buildInputField(emailController, false),
            const SizedBox(height: 30),
            _buildGreyText("Password"),
            _buildInputField(passwordController, true),
            const SizedBox(height: 20),
            _buildLoginButton(),
            const SizedBox(height: 30),
            _buildRememberForgot(),
            const SizedBox(height: 20),
            _buildOtherLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style:
          const TextStyle(color: Color.fromARGB(255, 65, 65, 65), fontSize: 16),
    );
  }

  Widget _buildInputField(TextEditingController controller, bool isPassword) {
    return isPassword
        ? TextField(
            controller: controller,
            obscureText: togglepassword,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    togglepassword = !togglepassword;
                  });
                },
                child: Icon(
                    togglepassword ? Icons.visibility_off : Icons.visibility),
              ),
            ),
          )
        : TextField(
            controller: controller,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.email),
            ),
            obscureText: false,
          );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            _buildGreyText("Don't have an account?"),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Signtp()));
          },
          child: const Text(
            "SignUp ",
            style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Email : ${emailController.text}");
        debugPrint("Password : ${passwordController.text}");
        login(emailController.text.toString(),
            passwordController.text.toString());
      },
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: Colors.deepOrange,
          minimumSize: const Size.fromHeight(60),
          backgroundColor: Colors.orange),
      child: const Text(
        "L O G I N",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Login with"),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset("assets/images/search.png")),
            ],
          )
        ],
      ),
    );
  }
}
