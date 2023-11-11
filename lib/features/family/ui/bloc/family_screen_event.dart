import 'package:makharej_app/features/profile/model/makharej_user.dart';

abstract class FamilyScreenEvent {
  final MakharejUser user;

  FamilyScreenEvent(this.user);
}

class FamilyScreenJoinFamilyEvent extends FamilyScreenEvent {
  final String familyId;

  FamilyScreenJoinFamilyEvent(
    this.familyId,
    MakharejUser makharejUser,
  ) : super(makharejUser);
}

class FamilyScreenCreateFamilyEvent extends FamilyScreenEvent {
  FamilyScreenCreateFamilyEvent(super.user);
}
