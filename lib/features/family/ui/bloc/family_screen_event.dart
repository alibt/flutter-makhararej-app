abstract class FamilyScreenEvent {
  final String uid;

  FamilyScreenEvent(this.uid);
}

class FamilyScreenJoinFamilyEvent extends FamilyScreenEvent {
  final String familyId;
  FamilyScreenJoinFamilyEvent(this.familyId, String uid) : super(uid);
}

class FamilyScreenCreateFamilyEvent extends FamilyScreenEvent {
  FamilyScreenCreateFamilyEvent(super.uid);
}
