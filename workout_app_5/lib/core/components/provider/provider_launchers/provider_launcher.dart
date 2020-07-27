import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_app_5/core/components/provider/selecting/workout_selection_provider.dart';

class ProviderLauncher extends StatelessWidget {
  
  

  @override
  Widget build(BuildContext context) {
    final workOutSelectionProvider = Provider.of<WorkOutSelectionProvider>(context);
    workOutSelectionProvider.launch();
    return Container(
      
    );
  }
}