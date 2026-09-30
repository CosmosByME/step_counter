part of 'user_details_cubit.dart';

sealed class UserDetailsState extends Equatable {
  const UserDetailsState();
}

final class UserDetailsInitial extends UserDetailsState {
  final int? age;
  final double? heightCm;
  final double? weightKg;
  final String? gender;

  const UserDetailsInitial({
    this.age,
    this.heightCm,
    this.weightKg,
    this.gender,
  });

  @override
  List<Object> get props => [];
}

final class UserDetailsUpdating extends UserDetailsState {
  final int? age;
  final double? heightCm;
  final double? weightKg;
  final String? gender;

  const UserDetailsUpdating({
    this.age,
    this.heightCm,
    this.weightKg,
    this.gender,
  });

  @override
  List<Object?> get props => [age, heightCm, weightKg, gender];

  UserDetailsUpdating copyWith({int? age, double? heightCm, double? weightKg}) {
    return UserDetailsUpdating(
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
    );
  }
}

final class UserDetailsFetched extends UserDetailsState {
  final int? age;
  final double? heightCm;
  final double? weightKg;
  final String? gender;

  const UserDetailsFetched({
    this.age,
    this.heightCm,
    this.weightKg,
    this.gender,
  });

  @override
  List<Object?> get props => [age, heightCm, weightKg, gender];
}

final class UserDetailsUpdated extends UserDetailsState {
  @override
  List<Object?> get props => [];
}

final class UserDetailsError extends UserDetailsState {
  final String message;

  const UserDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
