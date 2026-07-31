import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

/// Raw proximity sensor state — just reports if object is near/far.
class ProximityState {
  final bool isNear;
  final bool isAvailable;

  const ProximityState({this.isNear = false, this.isAvailable = false});

  ProximityState copyWith({bool? isNear, bool? isAvailable}) {
    return ProximityState(
      isNear: isNear ?? this.isNear,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}

/// Provider for raw proximity sensor data.
/// The call screen listens to this to blank the screen during a call.
final proximityProvider =
    StateNotifierProvider<ProximityNotifier, ProximityState>((ref) {
      return ProximityNotifier();
    });

class ProximityNotifier extends StateNotifier<ProximityState> {
  StreamSubscription<dynamic>? _proximitySubscription;

  ProximityNotifier() : super(const ProximityState()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final available = await ProximitySensor.isProximitySensorAvailable();
      state = state.copyWith(isAvailable: available);
      if (available) {
        _startListening();
      }
    } catch (_) {
      state = state.copyWith(isAvailable: false);
    }
  }

  void _startListening() {
    _proximitySubscription?.cancel();
    try {
      _proximitySubscription = ProximitySensor.events.listen((int event) {
        if (!mounted) return;
        state = state.copyWith(isNear: event > 0);
      });
    } catch (_) {
      state = state.copyWith(isAvailable: false);
    }
  }

  /// Force-enable listening (called when call screen opens)
  void forceStart() {
    if (_proximitySubscription == null && state.isAvailable) {
      _startListening();
    }
  }

  /// Force-stop listening (called when call screen closes)
  void forceStop() {
    _proximitySubscription?.cancel();
    _proximitySubscription = null;
    state = state.copyWith(isNear: false);
  }

  @override
  void dispose() {
    _proximitySubscription?.cancel();
    super.dispose();
  }
}
