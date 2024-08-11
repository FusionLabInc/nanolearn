import 'package:frontend/features/base/presentation/ui/widgets/app_bar.dart';
import 'package:frontend/features/overview/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final GlobalKey<ScaffoldState> appBaseScaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppConstants.appPrimaryColor.withOpacity(0.4),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          80.0,
        ),
        child: CustomAppBar(
          appBaseScaffoldKey: appBaseScaffoldKey,
        ),
      ),
      body: SizedBox(
        width: AppConstants.getWidth(context),
        height: AppConstants.getAppHeight(context),
        child: Expanded(
          child: ListView(
            children: const [],
          ),
        ),
      ),
    );
  }
}
