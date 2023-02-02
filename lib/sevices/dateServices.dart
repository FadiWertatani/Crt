import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crt_stand/models/date.dart';

class DateServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future addDateToCollection(DateModel dateM, String date) async {
    await _firebaseFirestore.collection('date').doc(date).set(dateM.toJson());
  }

  Future<DocumentSnapshot> getBusData(String serialN) async {
    return _firebaseFirestore.collection('bus').doc(serialN).get();
  }

  Stream<QuerySnapshot> getListVolunteerData(String date,String magasin) {
    return _firebaseFirestore
        .collection('date')
        .doc(date)
        .collection(magasin)
        .snapshots();
  }

  Future addMagasinToDate(String date, String magasin, String name) async {
    await _firebaseFirestore
        .collection('date')
        .doc(date)
        .collection(magasin)
        .doc(name)
        .set({"name":name});
  }

  Future addVolunteerToMagasin(String date, String magasin, String name, String timeF, String timeT) async {
    await _firebaseFirestore
        .collection('date')
        .doc(date)
        .collection(magasin)
        .doc(name)
        .set({"name":name,"timeFrom":timeF,"timeTo":timeT});
  }

  Future deleteVolunteerFromMagasin(String date, String magasin, String name) async {
    await _firebaseFirestore
        .collection('date')
        .doc(date)
        .collection(magasin)
        .doc(name)
        .delete();
  }

}
