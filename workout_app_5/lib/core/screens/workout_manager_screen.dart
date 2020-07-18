import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/provider/workout_manager_provider_v2.dart';
import 'package:workout_app_5/core/screens/workout_description.dart';
import 'package:workout_app_5/enums/workout_screen_state.dart';
import 'package:workout_app_5/widgets/buttons/back_button.dart';
import 'package:workout_app_5/widgets/buttons/question_button.dart';
import 'package:workout_app_5/widgets/buttons/skip_button.dart';
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment(-1.1, 0.6),
                              child: StatelessBackButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Flexible(
                              child: Center(
                                child: Text(
                                  'Work out has ended press the arrow to go back to selection screen.',
                                  style: kTitleTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                      ? SafeArea(
                          child: Scaffold(
                            body: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: SizedBox(),
                                  ),
                                  Flexible(
                                    flex: 1,
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
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: SkipButton(
                                      elevation: 8.0,
                                      borderRadius: 8,
                                      color: Color(0xFF2196F3),
                                      iconData: Icons.arrow_forward,
                                      onPressed: () {
                                        workOutManagerProviderV2
                                            .setCancelTimerTrue();
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SafeArea(
                          child: Scaffold(
                            body: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: StatelessBackButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    YesNoAlertDialog(
                                                  titleText:
                                                      'Are you sure you want to exit the workout?',
                                                  noButtonFunction: () {
                                                    Navigator.pop(context);
                                                  },
                                                  yesButtonFunction: () {
                                                    workOutManagerProviderV2
                                                        .disableTimer();
                                                    workOutManagerProviderV2
                                                        .clearIndex();
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              );
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
                                          child: QuestionButton(
                                            color: Color(0xFFeeeeee),
                                            elevation: 4.0,
                                            onPressed: () {
                                              workOutManagerProviderV2
                                                  .disableTimer();
                                              Navigator.pushNamed(context,
                                                  WorkOutDescriptionScreen.id);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: SizedBox(),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Consumer<
                                              WorkOutManagerProviderV2>(
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
                                    Flexible(
                                      flex: 1,
                                      child: SkipButton(
                                        elevation: 8.0,
                                        borderRadius: 8,
                                        color: Color(0xFF2196F3), //light blue
                                        iconData: Icons.arrow_forward,
                                        onPressed: () {
                                          workOutManagerProviderV2.useTimer
                                              ? workOutManagerProviderV2
                                                  .setCancelTimerTrue()
                                              : workOutManagerProviderV2
                                                  .finishExercise();
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: SizedBox(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
    );
  }
}

