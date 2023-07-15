import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_chat_list_event.dart';
part 'home_chat_list_state.dart';

class HomeChatListBloc extends Bloc<HomeChatListEvent, HomeChatListState> {
  HomeChatListBloc() : super(HomeChatListInitial()) {
    on<HomeChatListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
