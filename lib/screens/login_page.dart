import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_code/layout/mobile_screen_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;
  // bool _securityText = true;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    Fluttertoast.showToast(msg: "Welcome Buddy", toastLength: Toast.LENGTH_SHORT);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  Widget _buildGoogleButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 50,
          width: 40,
          child: GestureDetector(
            onTap: () async {
             await signInWithGoogle();
               setState(() {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const MobileScreenLayout()));
               });
            },
            child: Image.asset("assets/logobutton.png",
            height: 80,
            ),
          ),
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          border:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          labelText: "Email",
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: _secureText,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            icon: Icon(_secureText ? Icons.remove_red_eye : Icons.security),
            onPressed: () {
              setState(() {
                _secureText = !_secureText;
              });
            },
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          border:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          labelText: "Password",
        ));


    final loginButton = Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 6 * MediaQuery.of(context).size.width / 9,
        height: 45,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          gradient: const LinearGradient(
            colors: <Color>[
              Color(0xFF28B6ED),
              Color(0xFFE063FF),
            ],
          ),
        ),
        child: MaterialButton(
          onPressed: () {
            // signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFFFFFF)),
          ),
        ),
      ),
    );


    return SafeArea(
      child:SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            onTap: () {
              // setState(() {
              //   FocusScope.of(context).;
              // });
            },
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const Text(
                            "Hello again!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 3,
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Welcome back you've \n been missed!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF1F1F1F)),
                          ),
                        ],
                      ),
                      Container(
                        height: 240,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            emailField,
                            passwordField,
                            ],
                        ),
                      ),
                      loginButton,
                      Container(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "or continue with",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1F1F1F)),
                            ),
                            _buildGoogleButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
