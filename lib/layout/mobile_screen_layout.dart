import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_code/screens/login_page.dart';
import 'package:task_code/screens/home_page.dart';
import '../screens/logical.dart';
import '../widgets/gradient_icon.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout>
    with WidgetsBindingObserver, TickerProviderStateMixin
{
  late TabController tabController;
  final _auth = FirebaseAuth.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }



  void googleLogout() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    if (User != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => const LoginPage()));
    }
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: const Text(
            "HomeScreen"
          ),
          actions: [
            IconButton(onPressed: (){
              googleLogout();
            },
                icon: GradientIcon(
                  Icons.power_settings_new_rounded,
                  30,
                  const LinearGradient(
                    colors: <Color>[
                      Color(0XFF28B6ED),
                      Color(0XFFFA0AFF),
                    ],
                    end: Alignment.bottomRight,
                  ),
                ),
            )
          ],
          bottom: TabBar(
            labelColor: const Color(0XFF28B6ED),
            controller: tabController,
            tabs: const [
              Tab(
                text: 'User Details',

              ),
              Tab(
                text: 'Logical Terms',
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            HomePage(),
            LogicalPage()
          ],
        ),
      ),

    );
  }
}
