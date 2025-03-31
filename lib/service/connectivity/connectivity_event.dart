part of 'connectivity_service.dart';

abstract class ConnectivityEvent {}

/// 네트워크 상태가 변경되었을 때 발생하는 이벤트
class ConnectivityChangedEvent extends ConnectivityEvent {
  final bool isOnline;

  ConnectivityChangedEvent(this.isOnline);
}
