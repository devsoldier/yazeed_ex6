import 'package:flutter_bloc/flutter_bloc.dart';

class userText extends Cubit<String> {
  userText() : super('');

  void textInput(String text) => emit(text);

  void textClear() => emit('');
}
