import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:makharej_app/core/constants/firestore_collections_names.dart';
import 'package:makharej_app/features/profile/model/makharej_user.dart';

class UserProvider {
  Future<Either<Exception, MakharejUser>> getUser(String uid) async {
    try {
      final db = FirebaseFirestore.instance;
      MakharejUser? user;
      await db.collection(CollectionNames.users).doc(uid).get().then((value) {
        if (value.data() != null) user = MakharejUser.fromJson(value.data()!);
      });
      if (user != null) return right(user!);
      throw Exception();
    } on FirebaseException catch (e) {
      return left(e);
    } on Exception catch (e) {
      return left(e);
    }
  }

  Future<Either<Exception, MakharejUser>> registerNewUser(
      User firebaseUser) async {
    try {
      final makharejUser = await _addUser(firebaseUser);
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

  Future<void> updateUser(MakharejUser user) async {
    final db = FirebaseFirestore.instance;
    await db.collection(CollectionNames.users).doc(user.userID).update(
          user.toJson(),
        );
  }
}
