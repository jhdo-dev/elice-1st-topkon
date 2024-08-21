import 'package:alarm_front/domain/entities/room.dart';
import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  final int id;
  final int topic_id;
  final int player_id;
  final String name;
  final String topic_name;
  final String start_time;
  final String end_time;
  final String player_photoUrl;

  RoomModel({
    required this.id,
    required this.topic_id,
    required this.player_id,
    required this.name,
    required this.topic_name,
    required this.start_time,
    required this.end_time,
    required this.player_photoUrl,
  });

  @override
  List<Object> get props {
    return [
      id,
      topic_id,
      player_id,
      name,
      start_time,
      end_time,
      player_photoUrl,
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topic_id': topic_id,
      'player_id': player_id,
      'name': name,
      'start_time': start_time,
      'end_time': end_time,
      'player_photoUrl': player_photoUrl,
    };
  }

  factory RoomModel.fromJson(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id']?.toInt() ?? 0,
      topic_id: map['topic_id']?.toInt() ?? 0,
      player_id: map['player_id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      topic_name: map['topic_name'] ?? '',
      start_time: map['start_time'] ?? '',
      end_time: map['end_time'] ?? '',
      player_photoUrl: map['player_photoUrl'] ?? '',
    );
  }

  @override
  String toString() {
    return 'RoomModel(id: $id, topic_id: $topic_id, player_id: $player_id, name: $name, start_time: $start_time, end_time: $end_time)';
  }

  RoomModel copyWith({
    int? id,
    int? topic_id,
    int? player_id,
    String? name,
    String? topic_name,
    String? start_time,
    String? end_time,
  }) {
    return RoomModel(
      id: id ?? this.id,
      topic_id: topic_id ?? this.topic_id,
      player_id: player_id ?? this.player_id,
      name: name ?? this.name,
      topic_name: topic_name ?? this.topic_name,
      start_time: start_time ?? this.start_time,
      end_time: end_time ?? this.end_time,
      player_photoUrl: player_photoUrl ?? this.player_photoUrl,
    );
  }

  Room toEntity() {
    return Room(
      topicId: topic_id,
      id: id,
      roomName: name,
      topicName: topic_name,
      playerId: player_id,
      startTime: start_time,
      endTime: end_time,
      playerPhotoUrl: player_photoUrl,
    );
  }
}
