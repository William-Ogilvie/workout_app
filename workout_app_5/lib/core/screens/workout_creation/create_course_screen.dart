import 'package:flutter/material.dart';

class CreateCourseScreen extends StatelessWidget {
  static const id = 'create_course_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ListView.builder(
              //   itemCount: 20,
              //   itemBuilder: (context, index) {
              //     return Card(
              //       child: ListTile(
              //         onTap: () {},
              //         title: Text(locations[index].location),
              //       ),
              //     );
              //   },
              // ),
              
            ],
          ),
        ),
      ),
    );
  }
}
