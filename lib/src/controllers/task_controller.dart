import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes_app/src/controllers/notification_controller.dart';
import 'package:notes_app/src/screens/home_screen.dart';

class TaskController extends GetxController {
  static TaskController get instance => Get.find();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var tasks = <Map<String, dynamic>>[].obs;
  final NotificationController _notificationController =
      Get.find<NotificationController>();

  //add task
  Future<void> addTask({
    required String title,
    required String date,
    required String subtitle,
    required String description,
  }) async {
    try {
      isLoading(true);
      //Get current user Id
      String userId = _auth.currentUser!.uid;
      await Future.delayed(const Duration(seconds: 2));
      //task data
      Map<String, dynamic> taskData = {
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'dateTime': Timestamp.now(), // Add current date and time
        'date': date,
      };
      _notificationController.sendTaskNotification(
          "New Tasks Added", "Task $title");
      fetchTasks();

      //Add task to Firestore under the user's collection
      await _fireStore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .add(taskData);

      Get.snackbar('Success', 'Task added successfully!');
      Get.to(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Unknown error occurred');
    } finally {
      isLoading(false);
    }
  }

  //fetch task
  Future<void> fetchTasks() async {
    try {
      isLoading(true);
      String userId = _auth.currentUser!.uid;
      QuerySnapshot taskSnapshot = await _fireStore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .orderBy('dateTime', descending: true)
          .get();
      tasks.value = taskSnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'title': doc['title'],
          'subtitle': doc['subtitle'],
          'description': doc['description'],
          'date': doc['date'],
          'dateTime': Timestamp,
        };
      }).toList();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Unknown error occurred');
    } finally {
      isLoading(false);
    }
  }

  //update
  Future<void> updateTask({
    required String taskId,
    required String title,
    required String subtitle,
    required String description,
    required String date,
  }) async {
    try {
      isLoading(true);
      String userId = _auth.currentUser!.uid;

      await _fireStore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .update({
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'date': date,
        'dateTime': FieldValue.serverTimestamp(),
      });

      Get.snackbar('Success', 'Task updated successfully!');
      fetchTasks(); // Refresh task list
      Get.to(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Unknown error occurred');
    } finally {
      isLoading(false);
    }
  }

  // Delete Task Method
  Future<void> deleteTask(String taskId) async {
    try {
      isLoading(true);
      String userId = _auth.currentUser!.uid;

      await _fireStore
          .collection('users')
          .doc(userId)
          .collection('tasks')
          .doc(taskId)
          .delete();

      Get.snackbar('Success', 'Task deleted successfully!');
      _notificationController.sendTaskNotification(
          "Delete", "Your task has been deleted");
      fetchTasks(); // Refresh task list
      Get.to(() => const HomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Unknown error occurred');
    } finally {
      isLoading(false);
    }
  }
}
