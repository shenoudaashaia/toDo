import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_update/models/task_model.dart';
import 'package:to_do_update/models/user_modle.dart';

class FirebaseFunction {
  static CollectionReference<UserModle> getuserCollection() =>
      FirebaseFirestore.instance.collection("users").withConverter<UserModle>(
            fromFirestore: (snapshot, _) =>
                UserModle.fromjson(snapshot.data()!),
            toFirestore: (value, _) => value.tojson(),
          );

  static CollectionReference<TaskModel> getTaskCollection(String userId) =>
      getuserCollection()
          .doc(userId)
          .collection("tasks")
          .withConverter<TaskModel>(
            fromFirestore: (snapshot, _) =>
                TaskModel.fromJson(snapshot.data()!),
            toFirestore: (userModle, _) => userModle.toJson(),
          );

  static Future<void> addTaskToFirestore(TaskModel task, String userID) async {
    CollectionReference<TaskModel> taskCollection = getTaskCollection(userID);
    DocumentReference<TaskModel> docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<List<TaskModel>> getAllTaskFromFirestore(String userID) async {
    CollectionReference<TaskModel> taskCollection = getTaskCollection(userID);
    QuerySnapshot<TaskModel> querySnapshot = await taskCollection.get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<void> deleteTaskFromFirestore(String taskId, String userID) {
    CollectionReference<TaskModel> taskCollection = getTaskCollection(userID);
    return taskCollection.doc(taskId).delete();
  }

  static Future<void>updateTaskInfirebase(TaskModel task ,String uid)async{
    CollectionReference<TaskModel> collectionReference= getTaskCollection(uid);
    return collectionReference.doc(task.id).update(task.toJson());
  }

  static Future<UserModle> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credentials =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = UserModle(
      id: credentials.user!.uid,
      name: name,
      email: email,
    );
    final userCollection = getuserCollection();
    await userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<String?> fetchUserName() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      return userDoc["name"];
    }
    return null;
  }

  static Future<UserModle> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email and password cannot be empty");
    }

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final usercollection = getuserCollection();
      final docSnapshot = await usercollection.doc(credential.user!.uid).get();
      return docSnapshot.data()!;
    } catch (e) {
      print("Login failed: $e");
      throw Exception("Login failed: $e");
    }
  }

  static void logOut() => FirebaseAuth.instance.signOut();
}
