import 'package:alarm_front/data/datasources/room_datasource.dart';
import 'package:alarm_front/data/repositories/room_repo_impl.dart';
import 'package:alarm_front/domain/usecases/room/create_room_usecase.dart';
import 'package:alarm_front/domain/usecases/room/room_usecases.dart';
import 'package:alarm_front/presentation/bloc/room/room_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider(
      {required Dio dio}) async {
    final roomDatasource = RoomDatasource(dio: dio);
    final roomRepository = RoomRepoImpl(datasource: roomDatasource);
    final roomUsecase = RoomUsecases(
      createRoomUsecase: CreateRoomUsecase(repo: roomRepository),
    );

    return [
      RepositoryProvider<RoomDatasource>.value(value: roomDatasource),
      RepositoryProvider<RoomRepoImpl>.value(value: roomRepository),
      RepositoryProvider<RoomUsecases>.value(value: roomUsecase),
    ];
  }

  static BlocProvider getBlocProvider() {
    return BlocProvider<RoomBloc>(
      create: (context) =>
          RoomBloc(roomUsecases: RepositoryProvider.of(context)),
    );
  }
}
