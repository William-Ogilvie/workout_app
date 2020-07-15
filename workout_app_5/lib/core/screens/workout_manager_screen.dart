import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/provider/workout_manager_provider_v2.dart';
import 'package:workout_app_5/core/screens/workout_description.dart';
import 'package:workout_app_5/enums/workout_screen_state.dart';
import 'package:workout_app_5/widgets/reusable_button.dart';
import 'package:workout_app_5/widgets/show_dialog/yes_no_alert_dialog.dart';

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
                          Flexible(
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
              : WillPopScope(
                  onWillPop: () {
                    return showDialog(
                      context: context,
                      builder: (context) => YesNoAlertDialog(
                        titleText: 'Are you sure you want to exit the workout?',
                        noButtonFunction: () {
                          Navigator.pop(context, false);
                        },
                        yesButtonFunction: () {
                          workOutManagerProviderV2.disableTimer();
                          workOutManagerProviderV2.clearIndex();
                          Navigator.pop(context, true);
                        },
                      ),
                    );
                  },
                  child: workOutManagerProviderV2.workOutScreenState ==
                          WorkOutScreenState.rest
                      ? Scaffold(
                          body: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: SizedBox(),
                                ),
                                Flexible(
                                  child: Container(
                                    child: Consumer<WorkOutManagerProviderV2>(
                                      builder: (context,
                                              workOutManagerProviderV2,
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
                                    workOutManagerProviderV2
                                        .setCancelTimerTrue();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 1,
                                        child: ReusableButton(
                                          padding: 8.0,
                                          borderRadius: 12.0,
                                          text: '?',
                                          textStyle: kSmallerTextStyle,
                                          elevation: 8.0,
                                          onPressed: () {
                                            workOutManagerProviderV2
                                                .disableTimer();
                                            Navigator.pushNamed(context,
                                                WorkOutDescriptionScreen.id);
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        flex: 5,
                                        child: Container(
                                          child: Consumer<
                                              WorkOutManagerProviderV2>(
                                            builder: (context,
                                                    workOutManagerProviderV2,
                                                    child) =>
                                                Text(
                                              workOutManagerProviderV2
                                                  .workOutName,
                                              textAlign: TextAlign.center,
                                              style: kTitleTextStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: FlatButton(
                                          child: Icon(Icons.clear),
                                          onPressed: () {
                                            workOutManagerProviderV2
                                                .disableTimer();
                                            workOutManagerProviderV2
                                                .clearIndex();
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: SizedBox(),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child:
                                            Consumer<WorkOutManagerProviderV2>(
                                          builder: (context,
                                                  workOutManagerProviderV2,
                                                  child) =>
                                              Text(
                                            workOutManagerProviderV2.useTimer
                                                ? workOutManagerProviderV2
                                                    .currentTime
                                                    .toString()
                                                : '${workOutManagerProviderV2.repNumber.toString()} reps',
                                            style: kTimerTextStyle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
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
                ),
    );
  }
}
