import 'package:alarm_front/domain/usecases/room/create_room_usecase.dart';
import 'package:alarm_front/domain/usecases/room/get_room_usecase.dart';

class RoomUsecases {
  final CreateRoomUsecase createRoomUsecase;
  final GetRoomUsecase getRoomUsecase;
  RoomUsecases({required this.createRoomUsecase, required this.getRoomUsecase});
}
