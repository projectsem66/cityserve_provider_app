import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference refCategory =
    FirebaseFirestore.instance.collection('category');
final CollectionReference refProvider =
    FirebaseFirestore.instance.collection('providerDetails');
final CollectionReference refServices =
    FirebaseFirestore.instance.collection('providerServiceDetails');
final CollectionReference refBooking =
    FirebaseFirestore.instance.collection('bookings');
