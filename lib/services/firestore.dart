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
      Map<String, dynamic> dataWithId = {
        'id': docSnapshot.id,
        'data': docSnapshot.data(),
      };
      innsList.add(dataWithId);
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
      Map<String, dynamic> dataWithId = {
        'id': docSnapshot.id,
        'data': docSnapshot.data(),
      };
      transientList.add(dataWithId);
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
      Map<String, dynamic> dataWithId = {
        'id': docSnapshot.id,
        'data': docSnapshot.data(),
      };
      cottageList.add(dataWithId);
    }
  });
  return cottageList;
}

 Future<List<Map<String, dynamic>>> querySubCollection(String documentId, String subcollectionName) async {
    List<Map<String, dynamic>> subcollectionList = [];
    await db
        .collection('Accommodation') 
        .doc(documentId)
        .collection(subcollectionName)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        subcollectionList.add(docSnapshot.data());
      }
    });
    return subcollectionList;
  }
   Future<void> addBooking({
    required Map<String, dynamic> accommodation,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required Map<String, dynamic> room,
    required 
  }) async {
    try {
      await db.collection('bookings').add({
        'accommodation': accommodation,
        'checkInDate': checkInDate,
        'checkOutDate': checkOutDate,
        'room': room,
        // Add more fields as needed
      });
    } catch (e) {
      print('Error adding booking: $e');
      // Handle the error as needed
    }
  }
}

  

