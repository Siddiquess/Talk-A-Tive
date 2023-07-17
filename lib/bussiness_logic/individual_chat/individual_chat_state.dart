part of 'individual_chat_bloc.dart';

class IndividualChatState {
  List<String> messages = [];
  ApiResponse<IndividualChatModel> indChatModel;
  ApiResponse<List<GetIndividualMessagesModel>> getAllindChatModel;

  IndividualChatState({
    this.messages = const [],
    ApiResponse<IndividualChatModel>? indChatModel,
    ApiResponse<List<GetIndividualMessagesModel>>? getAllindChatModel,
  })  : indChatModel = indChatModel ?? ApiResponse.initial(),
        getAllindChatModel = getAllindChatModel ?? ApiResponse.initial();
}
