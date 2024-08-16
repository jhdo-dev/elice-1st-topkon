import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final int topicId;
  final int id;
  final String roomName;
  final String topicName;
  final int playerId;
  final String startTime;
  final String endTime;

  Room({
    required this.topicId,
    required this.id,
    required this.roomName,
    required this.topicName,
    required this.playerId,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object> get props {
    return [
      topicId,
      id,
      roomName,
      playerId,
      startTime,
      endTime,
    ];
  }

  // 포맷된 시작 시간 반환
  String getFormattedStartTime() {
    return _formatDateTime(startTime);
  }

  // 포맷된 종료 시간 반환
  String getFormattedEndTime() {
    return _formatDateTime(endTime);
  }

  // Private helper 메서드로 날짜 포맷팅 처리
  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
