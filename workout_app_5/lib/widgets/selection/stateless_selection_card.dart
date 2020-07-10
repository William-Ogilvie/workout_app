import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/selecting/workout_selection_provider.dart';
import 'package:workout_app_5/core/components/provider/workout_manager_provider_v2.dart';
import 'package:workout_app_5/core/screens/workout_manager_screen.dart';

class StatelessSelectionCard extends StatelessWidget {
  final String courseName;
  final int databaseId;

  StatelessSelectionCard({this.courseName,this.databaseId,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkOutManagerProviderV2 workOutManagerProviderV2 = Provider.of<WorkOutManagerProviderV2>(context, listen: false);
    return Consumer<WorkOutSelectionProvider>(
      builder: (context, workOutSelectionProvider, child) =>
      Card(
        color: Colors.white,
        child: ListTile(
          title: Text('$courseName'),
          enabled: true,
          selected: false,
          onTap: () async{
            workOutManagerProviderV2.fullReset();
            await workOutManagerProviderV2.setWorkOutCourse(databaseId);
            workOutManagerProviderV2.activateWorkOut();
            Navigator.pushNamed(context, WorkOutManagerScreen.id);
          },
        ),      
      ),
    );
  }
}

