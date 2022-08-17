import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();


}

class _HomePageState extends State<HomePage> {

  bool _isLoading = true;

  var googlePic;

  var useremail;

  var name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingName();

  }

  gettingName()async{
    final user = FirebaseAuth.instance.currentUser;

    useremail = user?.email;
    List<String> providerList = await FirebaseAuth.instance.fetchSignInMethodsForEmail(useremail);

    if (user != null) {



      if (providerList[0] == "google.com") {
        setState(() {
          googlePic = user.photoURL;
          name = user.displayName;
          _isLoading = false;
        });
        // print("this is from firebase$googlePic");
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  _isLoading ? const Center(child: CircularProgressIndicator()) :
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            googlePic != null
              ?
          Container  (
              height: 95,
              width: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(googlePic)
                )
              ),
            )
         :Container(),
            const SizedBox(
              height: 30,
            ),
            Text(name??"Please wait Getting Name"
            ),
            const SizedBox(
              height: 30,
            ),
            Text(useremail?? "Please wait Getting Email"),
          ],
        ),
      ),
    );
  }






}
