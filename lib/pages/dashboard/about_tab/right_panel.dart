import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:smart_city_dashboard/constants/text_styles.dart';
import 'package:smart_city_dashboard/kml_makers/kml_makers.dart';
import 'package:smart_city_dashboard/pages/dashboard/widgets/dashboard_right_panel.dart';
import 'package:smart_city_dashboard/utils/extensions.dart';

import '../../../constants/constants.dart';
import '../../../providers/settings_providers.dart';
import '../../../connections/ssh.dart';
import '../../../utils/helper.dart';

class AboutTabRight extends ConsumerStatefulWidget {
  const AboutTabRight({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AboutTabRightState();
}

class _AboutTabRightState extends ConsumerState<AboutTabRight> {
  int selectedTask = -1;

  @override
  Widget build(BuildContext context) {
    Color normalColor = ref.watch(normalColorProvider);
    Color oppositeColor = ref.watch(oppositeColorProvider);
    Color tabBarColor = ref.watch(tabBarColorProvider);
    Color highlightColor = ref.watch(highlightColorProvider);
    return DashboardRightPanel(
        headers: [translate('dashboard.about.available_options')],
        headersFlex: const [1],
        centerHeader: true,
        panelList: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: GestureDetector(
              onTap: () async {
                ref.read(isLoadingProvider.notifier).state = true;
                setState(() {
                  selectedTask = 0;
                });
                try {
                  File file = await SSH(ref: ref).makeFile(
                      Const.kmlOrbitFileName, KMLMakers.buildOrbit(ref));
                  if (!mounted) {
                    return;
                  }
                  await SSH(ref: ref)
                      .kmlFileUpload(context, file, Const.kmlOrbitFileName);
                  if (!mounted) {
                    return;
                  }
                  await SSH(ref: ref).runKml(context, Const.kmlOrbitFileName);
                  if (!mounted) {
                    return;
                  }
                  await SSH(ref: ref).startOrbit(
                    context,
                  );
                  if (!mounted) {
                    return;
                  }
                  await SSH(ref: ref)
                      .kmlFileUpload(context, file, Const.kmlOrbitFileName);
                  if (!mounted) {
                    return;
                  }
                  await SSH(ref: ref).runKml(context, Const.kmlOrbitFileName);
                  if (!mounted) {
                    return;
                  }
                  await SSH(ref: ref).startOrbit(
                    context,
                  );
                } catch (error) {
                  showSnackBar(context: context, message: error.toString());
                }
                ref.read(isLoadingProvider.notifier).state = false;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedTask == 0 ? highlightColor : null,
                  borderRadius:
                      BorderRadius.circular(Const.dashboardUIRoundness),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          size: Const.dashboardTextSize + 5,
                          color: oppositeColor,
                        ),
                        10.pw,
                        Text(
                          'Play Tour',
                          style: textStyleNormal.copyWith(
                              color: oppositeColor,
                              fontSize: Const.dashboardTextSize + 5),
                        ),
                      ],
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: GestureDetector(
              onTap: () async {
                ref.read(isLoadingProvider.notifier).state = true;
                setState(() {
                  selectedTask = 1;
                });
                await SSH(ref: ref).stopOrbit(
                  context,
                );
                ref.read(isLoadingProvider.notifier).state = false;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedTask == 1 ? highlightColor : null,
                  borderRadius:
                      BorderRadius.circular(Const.dashboardUIRoundness),
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.stop_rounded,
                          size: Const.dashboardTextSize + 5,
                          color: oppositeColor,
                        ),
                        10.pw,
                        Text(
                          'Stop Tour',
                          style: textStyleNormal.copyWith(
                              color: oppositeColor,
                              fontSize: Const.dashboardTextSize + 5),
                        ),
                      ],
                    )),
              ),
            ),
          )
        ]);
  }
}
