import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/provider/workout_manager_provider_v2.dart';
import 'package:workout_app_5/core/screens/workout_manager_screen.dart';
import 'package:workout_app_5/widgets/reusable_button.dart';



class WorkOutSelectionScreen extends StatelessWidget {
  static const String id = 'workout_selection_screen';
  
  @override
  Widget build(BuildContext context) {
    WorkOutManagerProviderV2 workOutManagerProviderV2 = Provider.of<WorkOutManagerProviderV2>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              // ReusableButton(
              //   borderRadius: 10.0,
              //   height: 200.0,
              //   elevation: 8.0,
              //   padding: 8.0,
              //   text: 'Testing',
              //   textStyle: kDefaultTextStyle,
              //   onPressed: () async{
              //     await workOutManagerProviderV2.setWorkOutCourse(1);
              //     await workOutManagerProviderV2.activateWorkOut();
              //   },
              // ),
              ReusableButton(
                borderRadius: 10.0,
                height: 200.0,
                elevation: 8.0,
                padding: 8.0,
                text: 'Stretching',
                textStyle: kDefaultTextStyle,
                onPressed: () async{
                  workOutManagerProviderV2.fullReset();
                  await workOutManagerProviderV2.setWorkOutCourse(1);
                  workOutManagerProviderV2.activateWorkOut();
                  Navigator.pushNamed(context, WorkOutManagerScreen.id);
                },
              ),
              ReusableButton(
                borderRadius: 10.0,
                height: 200.0,
                elevation: 8.0,
                padding: 8.0,
                text: 'Personal WorkOut',
                textStyle: kDefaultTextStyle,
                onPressed: () async{
                  workOutManagerProviderV2.fullReset();
                  await workOutManagerProviderV2.setWorkOutCourse(1);
                  workOutManagerProviderV2.activateWorkOut();
                  Navigator.pushNamed(context, WorkOutManagerScreen.id);
                },
              ),
              ReusableButton(
                borderRadius: 10.0,
                height: 200.0,
                elevation: 8.0,
                padding: 8.0,
                text: 'ABS',
                textStyle: kDefaultTextStyle,
                onPressed: () async{
                  workOutManagerProviderV2.fullReset();
                  await workOutManagerProviderV2.setWorkOutCourse(1);
                  workOutManagerProviderV2.activateWorkOut();
                  Navigator.pushNamed(context, WorkOutManagerScreen.id);
                },
              ),
              ReusableButton(
                borderRadius: 10.0,
                height: 200.0,
                elevation: 8.0,
                padding: 8.0,
                text: 'Arms',
                textStyle: kDefaultTextStyle,
                onPressed: () async{
                  workOutManagerProviderV2.fullReset();
                  await workOutManagerProviderV2.setWorkOutCourse(1);
                  workOutManagerProviderV2.activateWorkOut();
                  Navigator.pushNamed(context, WorkOutManagerScreen.id);
                },
              ),
              ReusableButton(
                borderRadius: 10.0,
                height: 200.0,
                elevation: 8.0,
                padding: 8.0,
                text: 'Legs',
                textStyle: kDefaultTextStyle,
                onPressed: () async{
                  workOutManagerProviderV2.fullReset();
                  await workOutManagerProviderV2.setWorkOutCourse(1);
                  workOutManagerProviderV2.activateWorkOut();
                  Navigator.pushNamed(context, WorkOutManagerScreen.id);
                },
              ),
              ReusableButton(
                borderRadius: 10.0,
                height: 200.0,
                elevation: 8.0,
                padding: 8.0,
                text: 'Full body',
                textStyle: kDefaultTextStyle,
                onPressed: () async{
                  workOutManagerProviderV2.fullReset();
                  await workOutManagerProviderV2.setWorkOutCourse(1);
                  workOutManagerProviderV2.activateWorkOut();
                  Navigator.pushNamed(context, WorkOutManagerScreen.id);
                },
              ),
              ReusableButton(
                borderRadius: 10.0,
                height: 200.0,
                elevation: 8.0,
                padding: 8.0,
                text: 'Lose fat',
                textStyle: kDefaultTextStyle,
                onPressed: () async{
                  workOutManagerProviderV2.fullReset();
                  await workOutManagerProviderV2.setWorkOutCourse(1);
                  workOutManagerProviderV2.activateWorkOut();
                  Navigator.pushNamed(context, WorkOutManagerScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}