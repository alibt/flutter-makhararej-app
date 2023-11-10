import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:makharej_app/features/family/model/family.dart';

@immutable
class FamilyScreenState extends Equatable {
  final bool isLoading;
  const FamilyScreenState({this.isLoading = false});

  FamilyScreenState copyWith({bool? isLoading}) {
    return FamilyScreenState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class FamilyScreenInitial extends FamilyScreenState {}

class FamilyScreenError extends FamilyScreenState {
  final String message;
  const FamilyScreenError(this.message);
}

class FamilyScreenSuccess extends FamilyScreenState {
  final Family family;
  const FamilyScreenSuccess(this.family);
}
