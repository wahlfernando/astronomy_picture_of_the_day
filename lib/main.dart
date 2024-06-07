import 'package:astronomy_picture_of_the_day/src/controllers/apod_controller.dart';
import 'package:astronomy_picture_of_the_day/src/views/apod_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => APODController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Astronomy Picture of the Day',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const APODList(),
      ),
    );
  }
}
