import 'package:equatable/equatable.dart';
import '../entities/user_message.dart';

abstract class LoadableState extends Equatable {

  bool get isLoading;

  bool get isFinished;

  UserMessage? get message;

  // Optionnel : permettre à un état de dire "ne m'affiche pas de loader global"
  bool get silentMode;

}