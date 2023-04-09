import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:makharej_app/core/constants/firestore_collections_names.dart';
import 'package:makharej_app/features/profile/model/makharej_user.dart';

class UserProvider {
  Future<Either<Exception, MakharejUser>> getUser(String uid) async {
    try {
      final db = FirebaseFirestore.instance;
      late MakharejUser user;
      await db.collection(CollectionNames.getUserPath(uid)).get().then((value) {
        user = MakharejUser.fromJson(value.docs.first.data());
      });
      return right(user);
    } on Exception catch (e) {
      return left(e);
    }
  }

  Future<Either<Exception, MakharejUser>> registerNewUser(
      User firebaseUser) async {
    try {
      final makharejUser = await _addUser(firebaseUser);
      final familyID = await _createFamilyWithUser(makharejUser.userID);
      makharejUser.familyID = familyID;
      await updateUser(makharejUser);
      return right(makharejUser);
    } on Exception catch (e) {
      return left(e);
    }
  }

  Future<MakharejUser> _addUser(User firebaseUser) async {
    final db = FirebaseFirestore.instance;
    final makahrejUser =
        MakharejUser(email: firebaseUser.email!, userID: firebaseUser.uid);
    final _ =
        await db.collection(CollectionNames.users).doc(firebaseUser.uid).set(
              makahrejUser.toJson(),
            );
    return makahrejUser;
  }

  Future<String> _createFamilyWithUser(String uid) async {
    final db = FirebaseFirestore.instance;

    final familyReference = await db.collection(CollectionNames.families).add(
      {
        'users': [uid]
      },
    );
    return familyReference.id;
  }

  Future<void> updateUser(MakharejUser user) async {
    final db = FirebaseFirestore.instance;
    await db.collection(CollectionNames.users).doc(user.userID).update(
          user.toJson(),
        );
  }
}
