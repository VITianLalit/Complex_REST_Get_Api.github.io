import 'dart:convert';

import 'package:flutter/material.dart';

import 'models/userModel.dart';
import 'package:http/http.dart' as http;

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      userList.clear();
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    return userList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("USER Api"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(), 
                builder: (context, snapshot){
                  return ListView.builder(
                    itemCount: userList.length,
                      itemBuilder: (context, index){
                        if(!snapshot.hasData){
                          return Text("Loading");
                        }else{
                          return Card(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Name: ' + snapshot.data![index].name.toString()),
                                  Text('E-mail: ' + snapshot.data![index].email.toString()),
                                  Text('Address: ' + snapshot.data![index].address!.street.toString() + ", "+ snapshot.data![index].address!.city.toString()),
                                  Text('Company: ' + snapshot.data![index].company!.name.toString()),
                                ],
                              ),
                            ),
                          );
                        }
                      }
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
