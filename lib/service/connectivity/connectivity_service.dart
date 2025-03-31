import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_event.dart';

class ConnectivityService extends Bloc<ConnectivityEvent, bool> {
  final Connectivity _connectivity;

  ConnectivityService({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity(),
      super(false) {
    on<ConnectivityChangedEvent>(_onConnectivityChanged);

    // 네트워크 상태 변경 감지
    _monitorConnectivity();
  }

  /// 네트워크 상태를 감지하고 이벤트를 추가
  void _monitorConnectivity() {
    _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      // 결과 리스트가 비어있지 않은 경우 첫 번째 결과 사용
      final result =
          results.isNotEmpty ? results.first : ConnectivityResult.none;

      // ConnectivityResult를 기반으로 온라인 상태를 계산
      final isOnline =
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet;
      add(ConnectivityChangedEvent(isOnline)); // 이벤트 추가
    });
  }

  /// 네트워크 상태 변경 이벤트 처리
  void _onConnectivityChanged(
    ConnectivityChangedEvent event,
    Emitter<bool> emit,
  ) {
    emit(event.isOnline); // 상태 업데이트
  }

  @override
  Future<void> close() {
    // 리소스 정리
    return super.close();
  }
}
