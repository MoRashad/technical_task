// ignore_for_file: must_be_immutable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, required this.id});
  int id;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDataLoaded = false;
  late var users;
  @override
  void initState() {
    getHttp();
    super.initState();
  }

  void getHttp() async {
    try {
      var response =
          await Dio().get('https://reqres.in/api/users/${widget.id}');
      users = response.data;
      setState(() {
        isDataLoaded = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("profile page"),
      ),
      body: isDataLoaded
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          users['data']['avatar'],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${users['data']["first_name"]} ${users['data']["last_name"]}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      users['data']['email'],
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
