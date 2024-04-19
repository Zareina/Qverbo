import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  FirebaseFirestore db = FirebaseFirestore.instance;


  List<Map<String, dynamic>> innsList = [];
  Future<List<Map<String, dynamic>>> queryInns() async {
    await db
        .collection('Accommodation')
        .where('Type', isEqualTo: 'inn')
        .get()
        .then((querySnapshot) {
         print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
        innsList.add(docSnapshot.data());
      }
    });
    return innsList;
  }

  List<Map<String, dynamic>> transientList = [];
  Future<List<Map<String, dynamic>>> queryTransients() async {
    await db
        .collection('Accommodation')
        .where('Type', isEqualTo: 'transient')
        .get()
        .then((querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
        transientList.add(docSnapshot.data());
      }
    });
    return transientList;
  }

  List<Map<String, dynamic>> cottageList = [];
  Future<List<Map<String, dynamic>>> queryCottages() async {
    await db
        .collection('Accommodation')
        .where('Type', isEqualTo: 'cottage')
        .get()
        .then((querySnapshot) {
         print("Successfully completed");
         for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
        cottageList.add(docSnapshot.data());
      }
    });
    return cottageList;
  }
  
}
