import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_app/src/widgets/task_text_field.dart';

import '../controllers/task_controller.dart';
import '../widgets/edit_button.dart';

class AddNotes extends StatefulWidget {
  final String? taskId;
  final String? title;
  final String? subtitle;
  final String? date;
  final String? description;

  const AddNotes(
      {super.key,
      this.taskId,
      this.title,
      this.subtitle,
      this.date,
      this.description});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController description = TextEditingController();

  final TaskController taskController = Get.find<TaskController>();

  void fillData() {
    if (widget.taskId != null) {
      title.text = widget.title ?? '';
      subtitle.text = widget.subtitle ?? '';
      description.text = widget.description ?? '';
      date.text = widget.date ?? "";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fillData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    widget.taskId == null
                        ? Text(
                            "Add New Task",
                            style: GoogleFonts.aBeeZee(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          )
                        : Text(
                            "Edit Task",
                            style: GoogleFonts.aBeeZee(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                  ],
                ),
                SizedBox(height: 15.h),
                Text(
                  "Task title",
                  style: GoogleFonts.actor(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 7.h),
                TaskTextField(controller: title, text: "Task title"),
                SizedBox(height: 10.h),
                Text(
                  "Context",
                  style: GoogleFonts.actor(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 7.h),
                TaskTextField(controller: subtitle, text: "Context"),
                SizedBox(height: 10.h),
                Text(
                  "Description",
                  style: GoogleFonts.actor(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 7.h),
                TaskTextField(
                  controller: description,
                  text: "Description",
                  maxLine: 4,
                ),
                SizedBox(height: 10.h),
                Text(
                  "Date",
                  style: GoogleFonts.actor(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 7.h),
                TaskTextField(controller: date, text: "Enter Date"),
                SizedBox(height: 40.h),
                Obx(
                  () {
                    return taskController.isLoading.value
                        ? const Center(
                            child: SizedBox(
                              height: 80,
                              width: 100,
                              child: LoadingIndicator(
                                indicatorType: Indicator.lineScale,
                                colors: [
                                  Colors.green,
                                  Colors.red,
                                  Colors.blue,
                                  Colors.yellow,
                                  Colors.orange,
                                ],
                                strokeWidth: 2,
                                //backgroundColor: Colors.black,
                                pathBackgroundColor: Colors.black,
                              ),
                            ),
                          )
                        : EditButton(
                            text: widget.taskId == null
                                ? "Add Task"
                                : "Update Task",
                            onPressed: () {
                              widget.taskId == null
                                  ? taskController.addTask(
                                      title: title.text.trim(),
                                      date: date.text.trim(),
                                      subtitle: subtitle.text.trim(),
                                      description: description.text.trim(),
                                    )
                                  : taskController.updateTask(
                                      taskId: widget.taskId!,
                                      title: title.text.trim(),
                                      subtitle: subtitle.text.trim(),
                                      description: description.text.trim(),
                                      date: date.text.trim(),
                                    );
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
