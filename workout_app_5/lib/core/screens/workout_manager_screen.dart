import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/provider/workout_manager_provider_v2.dart';
import 'package:workout_app_5/core/screens/workout_description.dart';
import 'package:workout_app_5/enums/workout_screen_state.dart';
import 'package:workout_app_5/widgets/reusable_button.dart';

class WorkOutManagerScreen extends StatelessWidget {
  static const String id = 'workout_manager_screen';
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkOutManagerProviderV2>(
      builder: (context, workOutManagerProviderV2, child) =>
          workOutManagerProviderV2.workOutEnded
              ? SafeArea(
                  child: Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: FlatButton(
                              child: Icon(
                                Icons.clear,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Work out has ended press x to go back to selection screen.',
                                style: kTitleTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : workOutManagerProviderV2.workOutScreenState == WorkOutScreenState.rest
                  ? Scaffold(
                      body: Center(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(),
                            ),
                            Expanded(
                              child: Container(
                                child: Consumer<WorkOutManagerProviderV2>(
                                  builder: (context, workOutManagerProviderV2,
                                          child) =>
                                      Text(
                                    workOutManagerProviderV2.currentTime
                                        .toString(),
                                    style: kTimerTextStyle.copyWith(
                                        fontSize: 60.0),
                                  ),
                                ),
                              ),
                            ),
                            ReusableButton(
                              elevation: 8.0,
                              text: 'Skip',
                              textStyle: kTitleTextStyle,
                              padding: 10.0,
                              borderRadius: 30.0,
                              onPressed: () {
                                workOutManagerProviderV2.setCancelTimerTrue();
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  : SafeArea(
                      child: Scaffold(
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: ReusableButton(
                                      padding: 8.0,
                                      borderRadius: 12.0,
                                      text: '?',
                                      textStyle: kSmallerTextStyle,
                                      elevation: 8.0,
                                      onPressed: () {
                                        workOutManagerProviderV2.disableTimer();
                                        Navigator.pushNamed(context,
                                            WorkOutDescriptionScreen.id);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: Consumer<WorkOutManagerProviderV2>(
                                        builder: (context,
                                                workOutManagerProviderV2,
                                                child) =>
                                            Text(
                                          workOutManagerProviderV2.workOutName,
                                          textAlign: TextAlign.center,
                                          style: kTitleTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: FlatButton(
                                      child: Icon(Icons.clear),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        workOutManagerProviderV2.disableTimer();
                                        workOutManagerProviderV2.clearIndex();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Text('IMAGES'),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Consumer<WorkOutManagerProviderV2>(
                                      builder: (context, workOutManagerProviderV2,
                                              child) =>
                                          Text(
                                        workOutManagerProviderV2.useTimer
                                            ? ''
                                            : '${workOutManagerProviderV2.repNumber.toString()} reps',
                                        style: kTimerTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Consumer<WorkOutManagerProviderV2>(
                                      builder: (context, workOutManagerProviderV2,
                                              child) =>
                                          Text(
                                        workOutManagerProviderV2.useTimer
                                            ? workOutManagerProviderV2.currentTime
                                                .toString()
                                            : '',
                                        style: kTimerTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ReusableButton(
                                    padding: 8.0,
                                    borderRadius: 12.0,
                                    text: 'Finish',
                                    textStyle: kDefaultTextStyle,
                                    elevation: 8.0,
                                    onPressed: () {
                                      workOutManagerProviderV2.useTimer
                                          ? workOutManagerProviderV2
                                              .setCancelTimerTrue()
                                          : workOutManagerProviderV2
                                              .finishExercise();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
    );
  }
}
