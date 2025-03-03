import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/src/screens/add_notes.dart';

import '../controllers/auth_controller.dart';
import '../controllers/task_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool event = true;
  final AuthController _authController = Get.find<AuthController>();

  final TaskController taskController = Get.find<TaskController>();
  // Fetch tasks when screen loads
  @override
  void initState() {
    super.initState();

    // Delay fetch to prevent setState issues during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskController.fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "My notes",
                        style: GoogleFonts.aBeeZee(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            Get.to(() => const AddNotes());
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: Colors.white,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(4),
                          ),
                          child: const Icon(
                            Icons.add_rounded,
                            color: Colors.green,
                            size: 27,
                          )),
                      ElevatedButton(
                          onPressed: () {
                            _authController.logout();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: Colors.white,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(4),
                          ),
                          child: Icon(
                            Icons.logout_rounded,
                            color: Colors.red[400],
                            size: 25,
                          )),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 597.h,
                    child: Obx(
                      () {
                        if (taskController.tasks.isEmpty) {
                          return Column(
                            children: [
                              Image.asset("assets/no-event.png"),
                              Text(
                                "There are no events yet!",
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          );
                        } else if (taskController.isLoading == false) {
                          return Column(
                            children: [
                              Image.asset("assets/no-event.png"),
                              Text(
                                "There are no events yet!",
                                style: GoogleFonts.actor(),
                              ),
                            ],
                          );
                        }
                        return ListView.builder(
                          itemCount: taskController.tasks.length,
                          itemBuilder: (context, index) {
                            final task = taskController.tasks[index];
                            return Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: MaterialButton(
                                elevation: 8,
                                onPressed: () {},
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.h),
                                ),
                                minWidth: 320.w,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 7.h, bottom: 10.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            task['date'].toString(),
                                            style: GoogleFonts.actor(
                                              color: Colors.black,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(() => AddNotes(
                                                    taskId: task["id"],
                                                    title: task["title"],
                                                    subtitle: task["subtitle"],
                                                    description:
                                                        task["description"],
                                                    date: task["date"],
                                                  ));
                                            },
                                            child: const Icon(
                                              Icons.edit_outlined,
                                              size: 21,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        task['title'],
                                        style: GoogleFonts.actor(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        task['description'],
                                        style: GoogleFonts.abel(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              taskController
                                                  .deleteTask(task['id']);
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              size: 21,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
