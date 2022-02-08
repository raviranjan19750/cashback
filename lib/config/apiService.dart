

import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:kick_cash/config/apiCustomException.dart';

class ApiService {


  Future<http.Response> post (String endpoint, var data) async {

    dynamic responseJson;
    try{
      var response = await http.post(Uri.parse(endpoint),
      body: jsonEncode(data),
      headers: {
        HttpHeaders.contentTypeHeader : "application/json"
      });
      responseJson = decodeResponseJson(response);
      printResponse(endpoint, responseJson);

    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;

  }

  Future<http.Response> put (String endpoint, var data) async {

    dynamic responseJson;

    try{

      var response = await http.put(Uri.parse(endpoint),
      body: jsonEncode(data),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json"
      });

      responseJson = decodeResponseJson(response);
      printResponse(endpoint, responseJson);


    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;


  }

  Future<http.Response> get (String endpoint) async {

    dynamic responseJson;

    try{
      var response = await http.get(Uri.parse(endpoint),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json"
      });
      responseJson = decodeResponseJson(response);
      printResponse(endpoint, responseJson);


    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;

  }

  Future<http.Response> delete (String endpoint) async {

    dynamic responseJson;

    try {
      var response  = await http.delete(Uri.parse(endpoint),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json"
      });
      responseJson = decodeResponseJson(response);
      printResponse(endpoint, responseJson);


    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;

  }

  dynamic decodeResponseJson (http.Response response) {

    switch(response.statusCode) {

      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;

      case 400:
        throw BadRequestException(response.body.toString());

      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());

      case 500:
      default:
        throw FetchDataException('Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }

  }

  void printResponse(String endpoint, dynamic responseJson) {

    print("Api response: $endpoint " + "$responseJson");

  }

}