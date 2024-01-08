
// ignore_for_file: unnecessary_type_check, file_names, camel_case_types, non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables, annotate_overrides, prefer_interpolation_to_compose_strings

import 'package:traffic_hero/Imports.dart';

class messagePage extends StatefulWidget {
  const messagePage({super.key});

  @override
  State<messagePage> createState() => _messagePageState();
}

class update {
  Update(messageLits) {

    try {
      _messagePageState().messageSave(messageLits);
    } catch (e) {
      print(e);
    }

  }
}

class _messagePageState extends State<messagePage> {
  var message;
  late SharedPreferences prefs;
  late stateManager state;

  @override
  void initState() {
    super.initState();
  }

  void didChangeDependencies() async {
    super.didChangeDependencies();
    state = Provider.of<stateManager>(context, listen: false);
    prefs = await SharedPreferences.getInstance();

    print('message:' + (prefs.get('message')).toString());
    final storedMessage = prefs.getString('message');
    if (storedMessage != null && storedMessage.trim().isNotEmpty) {
      try {
        // 使用 json.decode 還原 JSON 字串
        final decodedMessage =
            json.decode(storedMessage.trim()) as List<dynamic>;

        if (decodedMessage is List) {
          setState(() {
            message = decodedMessage;
            print(message);
            print(message.length);
          });
        } else {
          throw const FormatException("Invalid JSON format in SharedPreferences");
        }
      } catch (e) {
        print('Error decoding message: $e');
        // 如果解碼失敗，可以設定一個默認的非空列表
        setState(() {
          message = [
            {'title': '', 'body': '', 'payload': {}}
          ];
        });
      }
    } else {
      // 如果 storedMessage 為空，指定一個預設的非空列表
      setState(() {
        message = [
          {'title': '', 'body': '', 'payload': {}}
        ];
      });
    }
  }

  Future<void> messageSave(messageLits) async {
    print('更新中');

    final storedMessage = prefs.getString('message');
    if (storedMessage != null && storedMessage.trim().isNotEmpty) {
      try {
        // 使用 json.decode 還原 JSON 字串
        final decodedMessage =
            json.decode(storedMessage.trim()) as List<dynamic>;

        if (decodedMessage is List) {
          setState(() {
            message = decodedMessage;
            print(message);
            print(message.length);
          });
        } else {
          throw const FormatException("Invalid JSON format in SharedPreferences");
        }
      } catch (e) {
        print('Error decoding message: $e');
        // 如果解碼失敗，可以設定一個默認的非空列表
        setState(() {
          message = [
            {'title': '', 'body': '', 'payload': {}}
          ];
        });
      }
    } else {
      // 如果 storedMessage 為空，指定一個預設的非空列表
      setState(() {
        message = [
          {'title': '', 'body': '', 'payload': {}}
        ];
      });
    }
  }

  Widget listview() {
    return Expanded(
        child: ListView.builder(
            itemCount: message?.length ?? 0,
            itemBuilder: (context, index) {
              final messageList = message[index];
              return Column(
                children: [
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 30),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                messageList['title'].toString(),
                                style: const TextStyle(fontSize: 15),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    subtitle: Text(messageList['body'].toString()),
                    onTap: () {
                    
                    },
                  ),
                  const Divider(
                      thickness: 1,
                      color: Colors.grey,
                      indent: 10,
                      endIndent: 10)
                ],
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 111, 179, 1),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '通知',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: Column(
        children: [listview()],
      ),
    );
  }
}
