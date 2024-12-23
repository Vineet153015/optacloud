import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final int heartRate;
  final int stepCount;
  final bool isBluetoothConnected;

  DashboardLoaded({
    required this.heartRate,
    required this.stepCount,
    required this.isBluetoothConnected,
  });

  DashboardLoaded copyWith({
    int? heartRate,
    int? stepCount,
    bool? isBluetoothConnected,
  }) {
    return DashboardLoaded(
      heartRate: heartRate ?? this.heartRate,
      stepCount: stepCount ?? this.stepCount,
      isBluetoothConnected: isBluetoothConnected ?? this.isBluetoothConnected,
    );
  }

  @override
  List<Object?> get props => [heartRate, stepCount, isBluetoothConnected];
}
