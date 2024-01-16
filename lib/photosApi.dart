import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Photos{
  String title, url;
  Photos({required this.title, required this.url});
}

class PhotosApi extends StatefulWidget {
  const PhotosApi({super.key});

  @override
  State<PhotosApi> createState() => _PhotosApiState();
}

class _PhotosApiState extends State<PhotosApi> {
  
  List<Photos> photosList = [];
  Future<List<Photos>> getPhotosApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      photosList.clear();
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url']);
        photosList.add(photos);
      }
      return photosList;
    }else{
      return photosList;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos API'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child:  FutureBuilder(
                future: getPhotosApi(),
                builder: (context, snapshot){
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                          ),
                          title: Text(snapshot.data![index].title.toString()),
                        );
                      }
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
