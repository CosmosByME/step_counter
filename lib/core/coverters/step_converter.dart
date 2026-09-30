class StepConverter {
  static const double met = 3.5;
  static const double avgSpeed = 5.0;

  ///This formula is for calculating the step length in cm.
  ///for gender argument use ```1``` for male and ```2``` for female.
  static double getStepLengthCm({
    required double userHeightCm,
    required int gender,
  }) {
    final k = gender == 0 ? 0.415 : 0.413;
    return userHeightCm * k;
  }

  ///This formula is for calculating the total distance in meters.
  ///for gender argument use ```1``` for male and ```2``` for female.
  static double getTotalDistanceMeters({
    required double userHeightCm,
    required int gender,
    required int stepCount,
  }) {
    final stepLengthM =
        getStepLengthCm(userHeightCm: userHeightCm, gender: gender) / 100;
    return stepLengthM * stepCount;
  }


  ///This formula is for calculating the duration in hours.
  ///for gender argument use ```1``` for male and ```2``` for female.
  static double getDurationHour({
    required double userHeightCm,
    required int gender,
    required int stepCount,
  }) {
    final distanceKm =
        getTotalDistanceMeters(
          userHeightCm: userHeightCm,
          gender: gender,
          stepCount: stepCount,
        ) /
        1000;
    return distanceKm / avgSpeed;
  }


  ///This formula is for calculating the calories burned.
  ///for gender argument use ```1``` for male and ```2``` for female.
  ///userWeightKg is in kg.
  static double getCaloriesBurned({
    required double userHeightCm,
    required double userWeightKg,
    required int gender,
    required int stepCount,
  }) {
    final durationHour = getDurationHour(
      userHeightCm: userHeightCm,
      gender: gender,
      stepCount: stepCount,
    );
    return durationHour * userWeightKg * met;
  }
}
