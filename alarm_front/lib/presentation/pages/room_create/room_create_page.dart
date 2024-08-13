import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:flutter/material.dart';

class RoomCreatePage extends StatelessWidget {
  const RoomCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '방 생성',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              // 체크 버튼 클릭 시 처리할 코드 (추가 기능 필요 시 여기에 작성)
            },
          ),
        ],
      ),
      body: const RoomCreateForm(),
    );
  }
}

class RoomCreateForm extends StatefulWidget {
  const RoomCreateForm({super.key});

  @override
  _RoomCreateFormState createState() => _RoomCreateFormState();
}

class _RoomCreateFormState extends State<RoomCreateForm> {
  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTime;
  String? selectedTopic;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '방 이름',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _controller,
            style: TextStyles.mediumText,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: '',
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.bottomNavColor.withOpacity(0.5))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.bottomNavColor.withOpacity(0.5))),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            '주제 선택',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _showTopicDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.focusColor,
                foregroundColor: Colors.white,
                fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.9, 40), // 너비를 80%로 설정
              ),
              child: Text(
                selectedTopic ?? '선택하기',
                style: TextStyle(
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      offset: const Offset(1.0, 1.0), // 그림자의 위치
                      blurRadius: 5.0, // 그림자의 흐림 정도
                      color: Colors.black.withOpacity(0.5), // 그림자의 색상
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.center, // 왼쪽 정렬
            child: Text(
              '시작 일시',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _selectStartDateTime(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.focusColor,
                foregroundColor: Colors.white,
                fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.9, 40), // 너비를 80%로 설정
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedStartDateTime != null
                        ? '${"${selectedStartDateTime!.toLocal()}".split(' ')[0]} ${TimeOfDay.fromDateTime(selectedStartDateTime!).format(context)}'
                        : '선택하기',
                    style: TextStyle(
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          offset: const Offset(1.0, 1.0), // 그림자의 위치
                          blurRadius: 5.0, // 그림자의 흐림 정도
                          color: Colors.black.withOpacity(0.5), // 그림자의 색상
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.center,
            child: Text(
              '종료 일시',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _selectEndDateTime(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.focusColor,
                foregroundColor: Colors.white,
                fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.9, 40), // 너비를 80%로 설정
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedEndDateTime != null
                        ? '${"${selectedEndDateTime!.toLocal()}".split(' ')[0]} ${TimeOfDay.fromDateTime(selectedEndDateTime!).format(context)}'
                        : '선택하기',
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          offset: const Offset(1.0, 1.0), // 그림자의 위치
                          blurRadius: 5.0, // 그림자의 흐림 정도
                          color: Colors.black.withOpacity(0.5), // 그림자의 색상
                        ),
                      ],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTopicDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          content: Column(
            children: [
              const Text(
                '주제를 선택하세요.',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.focusColor,
                      border:
                          Border.all(color: Colors.black, width: 0.5), // 테두리 설정
                      borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedTopic = '주제 2'; // 선택한 주제를 설정
                        });
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                      child: Text(
                        '주제 1',
                        style: TextStyle(
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              offset: const Offset(1.0, 1.0), // 그림자의 위치
                              blurRadius: 5.0, // 그림자의 흐림 정도
                              color: Colors.black.withOpacity(0.5), // 그림자의 색상
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.black, width: 0.5), // 테두리 설정
                      borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedTopic = '선택하기'; // 선택한 주제를 설정
                        });
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                      child: Text(
                        '주제 2',
                        style: TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: const Offset(1.0, 1.0), // 그림자의 위치
                              blurRadius: 5.0, // 그림자의 흐림 정도
                              color: Colors.black.withOpacity(0.5), // 그림자의 색상
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.black, width: 0.5), // 테두리 설정
                      borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedTopic = '주제 2'; // 선택한 주제를 설정
                        });
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                      child: Text(
                        '주제 3',
                        style: TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: const Offset(1.0, 1.0), // 그림자의 위치
                              blurRadius: 5.0, // 그림자의 흐림 정도
                              color: Colors.black.withOpacity(0.5), // 그림자의 색상
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text(
                '취소',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.focusColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectStartDateTime(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedStartDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _selectEndDateTime(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedEndDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }
}
