import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:meta/meta.dart';

part 'scan_devices_state.dart';

class ScanDevicesCubit extends Cubit<ScanDevicesState> {
  ScanDevicesCubit() : super(ScanDevicesInitial());

  StreamSubscription<List<ScanResult>>? _scanResultsSub;
  final Map<String, ScanResult> _foundDevices = {};
  bool _isScanning = false;

  Future<void> scanDevices({
    List<Guid> withServices = const [],
    List<String> withNames = const [],
    Duration timeout = const Duration(seconds: 15),
  }) async {
    if (_isScanning) return;
    _isScanning = true;
    emit(ScanDevicesLoading());
    _foundDevices.clear();

    void emitSnapshot() {
      emit(ScanDevicesSuccess(devices: _foundDevices.values.toList()));
    }

    try {
      final supported = await FlutterBluePlus.isSupported;
      if (supported == false) {
        throw Exception('Bluetooth not supported on this device.');
      }

      _scanResultsSub = FlutterBluePlus.onScanResults.listen(
            (results) {
          var updated = false;
          for (final r in results) {
            final id = r.device.remoteId.toString();
            _foundDevices[id] = r;
            updated = true;
          }
          if (updated) emitSnapshot();
        },
        onError: (e, st) {
          emit(ScanDevicesFailure(message: e.toString()));
        },
      );

      FlutterBluePlus.cancelWhenScanComplete(_scanResultsSub!);

      await FlutterBluePlus.startScan(
        withServices: withServices,
        withNames: withNames,
        timeout: timeout,
      );

      await FlutterBluePlus.isScanning.where((v) => v == false).first;

      emitSnapshot();
    } on PlatformException catch (e) {
      emit(ScanDevicesFailure(message: e.message.toString()));
    }catch (e) {
      emit(ScanDevicesFailure(message: e.toString()));
    } finally {
      try {
        await FlutterBluePlus.stopScan();
      } catch (_) {}
      await _scanResultsSub?.cancel();
      _scanResultsSub = null;
      _isScanning = false;
    }
  }

  Future<void> stopScan() async {
    if (!_isScanning) return;
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      emit(ScanDevicesFailure(message: 'stopScan failed: ${e.toString()}'));
    } finally {
      await _scanResultsSub?.cancel();
      _scanResultsSub = null;
      _isScanning = false;
    }
  }

  @override
  Future<void> close() async {
    await _scanResultsSub?.cancel();
    return super.close();
  }
}
