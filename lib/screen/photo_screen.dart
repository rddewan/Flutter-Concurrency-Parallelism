

import 'package:concurrency_demo/model/photo.dart';
import 'package:concurrency_demo/service/network_service.dart';
import 'package:concurrency_demo/widget/photo_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class PhotoScreen extends StatefulWidget {
  const PhotoScreen({ Key? key }) : super(key: key);

  @override
  State createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  late NetworkService networkService;

  @override
  void initState() {   
    super.initState();
    networkService = NetworkService(client: http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo'),
      ),
      body: FutureBuilder<List<Photo>>(
        future: networkService.fetchPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}