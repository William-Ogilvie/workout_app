import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/provider/workout_manager_provider_v2.dart';
import 'package:workout_app_5/widgets/buttons/back_button.dart';

class WorkOutDescriptionScreen extends StatelessWidget {
  static const String id = 'workout_description_screen';

  @override
  Widget build(BuildContext context) {
    WorkOutManagerProviderV2 workOutManagerProviderV2 =
        Provider.of<WorkOutManagerProviderV2>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        workOutManagerProviderV2.restartTimer();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment(-1.1, 0.6),
                    child: StatelessBackButton(
                      onPressed: () {
                        Navigator.pop(context);
                        workOutManagerProviderV2.restartTimer();
                      },
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      workOutManagerProviderV2.workOutDescription,
                      style: kTitleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(),
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
