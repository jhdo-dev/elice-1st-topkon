import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RoomListPage(), // 첫 번째 페이지로 RoomListPage 설정
    );
  }
}

class RoomListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('방 목록'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // RoomCreatePage로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RoomCreatePage()),
            );
          },
          child: Text('방 생성 페이지로 가기'),
        ),
      ),
    );
  }
}

class RoomCreatePage extends StatelessWidget {
  const RoomCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // 체크 버튼 클릭 시 처리할 코드 (추가 기능 필요 시 여기에 작성)
            },
          ),
        ],
      ),
      body: RoomCreateForm(),
    );
  }
}

class RoomCreateForm extends StatefulWidget {
  @override
  _RoomCreateFormState createState() => _RoomCreateFormState();
}

class _RoomCreateFormState extends State<RoomCreateForm> {
  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTime;
  String? selectedTopic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '방 이름',
            style: TextStyle(fontSize: 10),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: '방 이름 입력',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            '주제 선택',
            style: TextStyle(fontSize: 10),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _showTopicDialog(context);
              },
              child: Text(
                selectedTopic ?? '선택하기',
                style: const TextStyle(fontSize: 10),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.9, 40), // 너비를 80%로 설정
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.centerLeft, // 왼쪽 정렬
            child: Text(
              '시작 일시',
              style: TextStyle(fontSize: 10),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _selectStartDateTime(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedStartDateTime != null
                        ? "${selectedStartDateTime!.toLocal()}".split(' ')[0] +
                            ' ' +
                            TimeOfDay.fromDateTime(selectedStartDateTime!)
                                .format(context)
                        : '선택하기',
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.9, 40), // 너비를 80%로 설정
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '종료 일시',
              style: TextStyle(fontSize: 10),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _selectEndDateTime(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedEndDateTime != null
                        ? "${selectedEndDateTime!.toLocal()}".split(' ')[0] +
                            ' ' +
                            TimeOfDay.fromDateTime(selectedEndDateTime!)
                                .format(context)
                        : '선택하기',
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                    MediaQuery.of(context).size.width * 0.9, 40), // 너비를 80%로 설정
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
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5), // 테두리 설정
                  borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTopic = '주제 2'; // 선택한 주제를 설정
                    });
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                  child: Text('주제 2'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5), // 테두리 설정
                  borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTopic = '주제 2'; // 선택한 주제를 설정
                    });
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                  child: Text('주제 2'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5), // 테두리 설정
                  borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTopic = '주제 2'; // 선택한 주제를 설정
                    });
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                  child: Text('주제 2'),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text('취소'),
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
