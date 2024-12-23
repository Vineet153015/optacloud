import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDashboardEvent extends DashboardEvent {}

class UpdateHeartRateEvent extends DashboardEvent {
  final int heartRate;
  UpdateHeartRateEvent(this.heartRate);

  @override
  List<Object?> get props => [heartRate];
}

class UpdateStepCountEvent extends DashboardEvent {
  final int stepCount;
  UpdateStepCountEvent(this.stepCount);

  @override
  List<Object?> get props => [stepCount];
}
