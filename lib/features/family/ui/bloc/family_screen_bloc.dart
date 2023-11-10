import 'package:bloc/bloc.dart';
import 'package:makharej_app/features/family/provider/family_provider.dart';
import 'package:makharej_app/features/family/ui/bloc/family_screen_event.dart';
import 'package:makharej_app/features/family/ui/bloc/family_screen_state.dart';
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
    familyProvider.createFamily(event.uid);
    emitter(state.copyWith(isLoading: false));
  }
}
