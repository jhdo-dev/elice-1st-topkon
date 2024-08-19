import 'package:alarm_front/domain/usecases/room/create_room_usecase.dart';
import 'package:alarm_front/domain/usecases/room/get_room_usecase.dart';
import 'package:alarm_front/domain/usecases/room/get_rooms_by_ids_usecase.dart';

class RoomUsecases {
  final CreateRoomUsecase createRoomUsecase;
  final GetRoomUsecase getRoomUsecase;
  final GetRoomsByIdsUsecase getRoomsByIdsUsecase;

  RoomUsecases({
    required this.createRoomUsecase,
    required this.getRoomUsecase,
    required this.getRoomsByIdsUsecase,
  });
}
