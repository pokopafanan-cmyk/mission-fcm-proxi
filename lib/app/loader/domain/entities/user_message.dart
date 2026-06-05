import 'package:uuid/uuid.dart';

enum MessageType { success, error, info }

class UserMessage {

  final String id;
  final String text;
  final MessageType type;

  UserMessage({
    required this.text,
    this.type = MessageType.error,
  }) : id = const Uuid().v4();

}