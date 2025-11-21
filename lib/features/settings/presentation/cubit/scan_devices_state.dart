part of 'scan_devices_cubit.dart';

@immutable
sealed class ScanDevicesState {}

final class ScanDevicesInitial extends ScanDevicesState {}
final class ScanDevicesLoading extends ScanDevicesState {}
final class ScanDevicesSuccess extends ScanDevicesState {
  final List<ScanResult> devices;

  ScanDevicesSuccess({required this.devices});
}
final class ScanDevicesFailure extends ScanDevicesState {
  final String message;

  ScanDevicesFailure({required this.message});
}
