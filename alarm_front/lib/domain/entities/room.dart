import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Room extends Equatable {
  final int topicId;
  final int id;
  final String roomName;
  final String topicName;
  final int playerId;
  final String startTime;
  final String endTime;
  final String playerPhotoUrl;

  Room({
    required this.topicId,
    required this.id,
    required this.roomName,
    required this.topicName,
    required this.playerId,
    required this.startTime,
    required this.endTime,
    required this.playerPhotoUrl,
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
      playerPhotoUrl,
    ];
  }

  String getFormattedStartTime() {
    return _formatDateTime(startTime);
  }

  String getFormattedEndTime() {
    return _formatDateTime(endTime);
  }

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    DateTime localDateTime = dateTime.toLocal();

    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

    return formatter.format(localDateTime);
  }
}
