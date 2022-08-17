import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_code/screens/login_page.dart';
import 'package:task_code/layout/mobile_screen_layout.dart';
import 'package:task_code/providers/user_provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const MobileScreenLayout();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future has not been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return AnimatedSplashScreen(
              duration: 3000,
              splash: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/bg.jpg",
                    fit: BoxFit.fill,
                  ),
                  Center(
                    child: Text(
                      "Welcome",
                      style: GoogleFonts.rumRaisin(
                        fontSize: 41,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              splashIconSize: double.maxFinite,
              centered: true,
              splashTransition: SplashTransition.fadeTransition,
              nextScreen: const LoginPage(),
            );
          },
        ),
      ),
    );

  }
}

