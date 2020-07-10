import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/provider/selecting/workout_selection_provider.dart';
import 'package:workout_app_5/core/components/provider/workout_manager_provider_v2.dart';
import 'package:workout_app_5/core/screens/workout_manager_screen.dart';
import 'package:workout_app_5/widgets/reusable_button.dart';



class WorkOutSelectionScreen extends StatelessWidget {
  static const String id = 'workout_selection_screen';
  
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(12.0),
          child: Center(
            child: CreatedCourseListView(),
          ),
        ),
      ),
    );
  }
}

class CreatedCourseListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutSelectionProvider>(
      builder: (context, workOutSelectionProvider, child) => ListView.builder(
        itemCount: workOutSelectionProvider.statelessSelectionCardList.length,
        itemBuilder: (context, index) {
          return workOutSelectionProvider.statelessSelectionCardList[index];
        },
      ),
    );
  }
}



