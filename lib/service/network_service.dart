
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
    );

    // get the first element from the stream
    final result = await receivePort.first;

    return result as List<Photo>;
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