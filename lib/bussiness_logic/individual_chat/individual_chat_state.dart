part of 'individual_chat_bloc.dart';

class IndividualChatState {
  List<Map<String,String>> messages = [];
  ApiResponse<IndividualChatModel> indChatModel;
  ApiResponse<List<GetIndividualMessagesModel>> getAllindChatModel;

  IndividualChatState({
    this.messages = const [] ,
    ApiResponse<IndividualChatModel>? indChatModel,
    ApiResponse<List<GetIndividualMessagesModel>>? getAllindChatModel,
  })  : indChatModel = indChatModel ?? ApiResponse.initial(),
        getAllindChatModel = getAllindChatModel ?? ApiResponse.initial();

   IndividualChatState copyWith({
    List<Map<String,String>> messages = const [],
    ApiResponse<IndividualChatModel>? indChatModel,
    ApiResponse<List<GetIndividualMessagesModel>>? getAllindChatModel,
  }) {
    return IndividualChatState(
      messages: messages ,
      indChatModel: indChatModel ?? this.indChatModel,
      getAllindChatModel: getAllindChatModel ?? this.getAllindChatModel,
    );
  }
}

