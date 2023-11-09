import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makharej_app/features/authentication/provider/firebase_auth_provider.dart';

import '../../../core/constants/firestore_collections_names.dart';

class FamilyProvider {
  final FirebaseAuthProvider authProvider;

  FamilyProvider(this.authProvider);

  Future<String> createFamily(String uid) async {
    final db = FirebaseFirestore.instance;

    final familyReference = await db.collection(CollectionNames.families).add(
      {
        'users': [uid],
        'createdBy': uid,
      },
    );
    return familyReference.id;
  }

  Future<void> addUserToFamily(String familyId, String userId) async {
    final db = FirebaseFirestore.instance;

    await db.collection(CollectionNames.families).doc(familyId).update({
      'users': FieldValue.arrayUnion([userId]),
    });
  }
}
