import 'dart:convert';
import 'package:campus_mart/Model/MessageModel.dart';
import 'package:campus_mart/Network/error_handler.dart';
import 'package:campus_mart/Network/network_util.dart';
import 'package:campus_mart/Utils/conn.dart';

class MessageClass {

  NetworkHelper networkHelper = NetworkHelper();
  ErrorHandler errorHandler = ErrorHandler();

  Map<String, String>?  headers;

  String messageEndpoint ="$conn/message";

  Future addMessage(data, token){
    Chat? chat;
    headers  = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": token
    };
    return networkHelper.post(messageEndpoint, headers: headers, body: data,
      encoding: Encoding.getByName("utf-8"),)
        .then((dynamic res) async{
      Map<String, dynamic> response = res;
      chat = Chat.fromJson(response);
      return chat;
    }).catchError((err){
      errorHandler.handleError(err['body']);
    });
  }

  Future getMessages(data, token){
    List<MessageModel>? messageModel;
    headers  = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": token
    };
    return networkHelper.get("$messageEndpoint/$data", headers: headers)
        .then((dynamic res) async{
          print(res);
          Map<String, dynamic> response = res;
          messageModel = response['data'].map<MessageModel>(
                  (json) => MessageModel.fromJson(json))
              .toList();
      return messageModel;
    }).catchError((err){
      errorHandler.handleError(err['body']);
    });
  }

  Future setAsRead(data, token){
    List<MessageModel>? messageModel;
    headers  = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": token
    };
    return networkHelper.get("$messageEndpoint/read/$data", headers: headers, body: data)
        .then((dynamic res) async{
      return res;
    }).catchError((err){
      errorHandler.handleError(err['body']);
    });
  }


}