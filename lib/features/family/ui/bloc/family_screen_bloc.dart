import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:makharej_app/features/family/provider/family_provider.dart';
import 'package:makharej_app/features/family/ui/bloc/family_screen_event.dart';
import 'package:makharej_app/features/family/ui/bloc/family_screen_state.dart';
import 'package:makharej_app/features/profile/model/makharej_user.dart';
import 'package:makharej_app/features/profile/provider/user_provider.dart';

class FamilyBloc extends Bloc<FamilyScreenEvent, FamilyScreenState> {
  final FamilyProvider familyProvider;
  final UserProvider userProvider;
  FamilyBloc(
    this.familyProvider,
    this.userProvider,
  ) : super(FamilyScreenInitial()) {
    on<FamilyScreenJoinFamilyEvent>(handleJoinFamily);
    on<FamilyScreenCreateFamilyEvent>(handleCreateFamily);
  }

  Future<void> handleJoinFamily(
    FamilyScreenJoinFamilyEvent event,
    Emitter<FamilyScreenState> emitter,
  ) async {
    emitter(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 2));
    emitter(state.copyWith(isLoading: false));
  }

  Future<void> handleCreateFamily(
    FamilyScreenCreateFamilyEvent event,
    Emitter<FamilyScreenState> emitter,
  ) async {
    emitter(state.copyWith(isLoading: true));
    var response = await familyProvider.createFamily(event.user.userID);
    await response.fold<FutureOr<void>>(
      (exception) => emitter(
        FamilyScreenErrorState(exception.toString()),
      ),
      (familyID) async => await onSuccessfullyCreateFamily(
        familyID,
        emitter,
        event.user,
      ),
    );
  }

  Future<void> onSuccessfullyCreateFamily(String familyID,
      Emitter<FamilyScreenState> emitter, MakharejUser user) async {
    var response =
        await userProvider.updateUser(user.copyWith(familyID: familyID));
    response.fold(
      (exception) => emitter(
        FamilyScreenErrorState(
          exception.toString(),
        ),
      ),
      (user) => emitter(
        const FamilyScreenSuccessState(),
      ),
    );
  }
}
