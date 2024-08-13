import 'package:alarm_front/domain/entities/topic.dart';
import 'package:equatable/equatable.dart';

class TopicModel extends Equatable {
  final int id;
  final String name;
  final String room_count;
  TopicModel({
    required this.id,
    required this.name,
    required this.room_count,
  });

  @override
  List<Object> get props => [id, name, room_count];

  @override
  String toString() =>
      'TopicModel(id: $id, name: $name, room_count: $room_count)';

  TopicModel copyWith({
    int? id,
    String? name,
    String? room_count,
  }) {
    return TopicModel(
      id: id ?? this.id,
      name: name ?? this.name,
      room_count: room_count ?? this.room_count,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'room_count': room_count,
    };
  }

  factory TopicModel.fromJson(Map<String, dynamic> map) {
    return TopicModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      room_count: map['room_count'] ?? '',
    );
  }

  Topic toEntity() {
    return Topic(
      id: id,
      name: name,
      roomCount: room_count,
    );
  }
}
