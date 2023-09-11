part of 'individual_chat_bloc.dart';

class IndividualChatState {
  List<Map<String, String>> messages = [];
  String isConnected= "";
  bool isTyping;
  ApiResponse<IndividualChatModel> indChatModel;
  ApiResponse<List<GetIndividualMessagesModel>> getAllindChatModel;

  IndividualChatState({
    this.messages = const [],
    this.isConnected ="",
    this.isTyping = false,
    ApiResponse<IndividualChatModel>? indChatModel,
    ApiResponse<List<GetIndividualMessagesModel>>? getAllindChatModel,
  })  : indChatModel = indChatModel ?? ApiResponse.initial(),
        getAllindChatModel = getAllindChatModel ?? ApiResponse.initial();

  IndividualChatState copyWith({
    List<Map<String, String>>? messages,
    String? isConnected,
    bool? isTyping,
    ApiResponse<IndividualChatModel>? indChatModel,
    ApiResponse<List<GetIndividualMessagesModel>>? getAllindChatModel,
  }) {
    return IndividualChatState(
      isConnected: isConnected?? this.isConnected,
      isTyping: isTyping??this.isTyping,
      messages: messages ?? this.messages,
      indChatModel: indChatModel ?? this.indChatModel,
      getAllindChatModel: getAllindChatModel ?? this.getAllindChatModel,
    );
  }
}
