import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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

class FamilyScreenErrorState extends FamilyScreenState {
  final String message;
  const FamilyScreenErrorState(this.message);
}

class FamilyScreenSuccessState extends FamilyScreenState {
  const FamilyScreenSuccessState();
}
