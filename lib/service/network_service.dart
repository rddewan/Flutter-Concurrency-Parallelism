
import 'dart:convert';
import 'dart:isolate';

import 'package:concurrency_demo/model/photo.dart';
import 'package:http/http.dart' as http;


class NetworkService {
  final http.Client client;

  NetworkService({required this.client});


  Future<List<Photo>> fetchPhotos() async {
    final receivePort = ReceivePort();
    
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );

    Isolate.spawn(
      parsePhotos,
      [
        response.body,
        receivePort.sendPort,
      ],
      // onExit argument makes the isolate send null to the port upon exiting.
      onExit: receivePort.sendPort,
      // onError argument makes an uncaught error send a list of two strings 
      // to the port (the toString of both the error and stack trace)
      onError: receivePort.sendPort,
      debugName: 'Parse a photo json'
    );

    // get the first element from the stream
    final result = await receivePort.first;

    // check if result is null, 
    // meaning the isolate terminated without sending results
    if (result == null) {
      throw Exception('Isolate terminated without result');
    }

    //check if the result is a list, meaning an uncaught error occurred
    if (result is List && result is !List<Photo>) {
      var error = result[0];
      var stackTrace = result[1];

      // check if result[1] is StackTrace
      if (stackTrace is StackTrace) {
        // do something 
      }

      throw Exception(error.toString());
    }

    return result as List<Photo>;
  }

  Future<List<Photo>> fetchPhotosFromApi() async {
    
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );

    final result = await Isolate.run(
      () => mapToPhotos(response.body),
      debugName: 'Parse a photo json'
    );
   
    return result;
  }


}



// top level function for isolate
// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(List<dynamic> args) {
  String responseBody = args[0];
  SendPort responsePort = args[1];
  
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  final result = parsed.map<Photo>((json) => Photo.fromJson(json))
    .toList() as List<Photo>;
  
  Isolate.exit(responsePort, result);
}

List<Photo> mapToPhotos(String responseBody) {
    
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  final result = parsed.map<Photo>((json) => Photo.fromJson(json))
    .toList() as List<Photo>;
  
  return result;
}