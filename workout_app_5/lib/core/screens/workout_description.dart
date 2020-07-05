import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/constants/text_styles.dart';
import 'package:workout_app_5/core/components/provider/workout_manager_provider_v2.dart';

class WorkOutDescriptionScreen extends StatelessWidget {
  static const String id = 'workout_description_screen';

  @override
  Widget build(BuildContext context) {
    WorkOutManagerProviderV2 workOutManagerProviderV2 =
        Provider.of<WorkOutManagerProviderV2>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FlatButton(
                child: Icon(Icons.clear,),
                onPressed: () {
                  Navigator.pop(context);
                  workOutManagerProviderV2.restartTimer();
                },
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                workOutManagerProviderV2.workOutDescription,
                style: kTitleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
