import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/src/controllers/auth_controller.dart';
import 'package:notes_app/src/controllers/notification_controller.dart';
import 'package:notes_app/src/controllers/task_controller.dart';
import 'package:notes_app/src/screens/add_notes.dart';
import 'package:notes_app/src/screens/home_screen.dart';
import 'package:notes_app/src/screens/login_screen.dart';
import 'package:notes_app/src/screens/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //
  Get.put(NotificationController());
  Get.put(AuthController());
  Get.put(TaskController());

  //Get.lazyPut(() => NotificationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Notes App',
            initialRoute: '/login',
            getPages: [
              GetPage(name: '/login', page: () => const LoginScreen()),
              GetPage(name: '/home', page: () => const HomeScreen()),
              GetPage(
                  name: '/registration',
                  page: () => const RegistrationScreen()),
              GetPage(name: '/addTask', page: () => const AddNotes()),
            ],
          );
        });
  }
}
