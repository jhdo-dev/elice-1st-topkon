import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/domain/entities/room.dart';
import 'package:alarm_front/presentation/bloc/filter/filter_bloc.dart';
import 'package:alarm_front/presentation/bloc/room/room_bloc.dart';
import 'package:alarm_front/presentation/pages/room_list/widgets/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RoomListPage extends StatefulWidget {
  RoomListPage({super.key});

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  final _pageSize = 10;
  final PagingController<int, Room> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  void _fetchPage(int pageKey) {
    context.read<LoadRoomBloc>().add(
          LoadRoomEvent(
            offset: pageKey,
            topicId: BlocProvider.of<FilterBloc>(context).state.selectedIndex,
          ),
        );
  }

  Future<void> _refresh() async {
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoadRoomBloc, RoomState>(
          listener: (context, state) {
            if (state is GetRoomLoaded) {
              final newItems = state.rooms;
              final isLastPage = newItems.length < _pageSize;
              if (isLastPage) {
                _pagingController.appendLastPage(newItems);
              } else {
                final nextPageKey =
                    _pagingController.nextPageKey! + newItems.length;
                _pagingController.appendPage(newItems, nextPageKey);
              }
            } else if (state is GetRoomError) {
              _pagingController.error = state.message;
            }
          },
        ),
        BlocListener<FilterBloc, FilterState>(
          listener: (context, state) {
            _pagingController.refresh();
          },
        ),
        BlocListener<CreateRoomBloc, RoomState>(
          listener: (context, state) {
            if (state is CreateRoomSuccess) {
              _pagingController.refresh();
            }
          },
        ),
      ],
      child: RefreshIndicator(
        color: Colors.blue,
        backgroundColor: AppColors.backgroundColor, // 배경 색상 조정
        strokeWidth: 3.0,
        displacement: 40,
        onRefresh: _refresh,
        child: PagedListView<int, Room>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Room>(
            itemBuilder: (context, item, index) => ChatRoom(
              subjectName: item.topicName,
              roomName: item.roomName,
              roomStartDate: item.getFormattedStartTime(),
              roomEndDate: item.getFormattedEndTime(),
              id: item.id,
            ),
          ),
        ),
      ),
    );
  }
}
