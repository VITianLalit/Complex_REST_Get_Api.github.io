import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Uuserss extends StatefulWidget {
  const Uuserss({super.key});

  @override
  State<Uuserss> createState() => _UuserssState();
}

class _UuserssState extends State<Uuserss> {

  var data;
  Future<void> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
     if(response.statusCode == 200){
       data = jsonDecode(response.body.toString());
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users API"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Text("Loading");
                }else{
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index){
                        return Card(
                          child: Container(
                            child: Column(
                              children: [
                                Text("Name: " + data[index]['name'].toString()),
                                Text("Address: " + data[index]['address']['street'].toString()),
                                Text("Geo: " + data[index]['address']['geo']['lat']),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

