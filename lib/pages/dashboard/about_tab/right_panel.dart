import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_city_dashboard/constants/text_styles.dart';
import 'package:smart_city_dashboard/kml_makers/kml_makers.dart';
import 'package:smart_city_dashboard/pages/dashboard/dashboard_right_panel.dart';
import 'package:smart_city_dashboard/providers/data_providers.dart';
import 'package:smart_city_dashboard/widgets/extensions.dart';

import '../../../constants/constants.dart';
import '../../../constants/texts.dart';
import '../../../constants/theme.dart';
import '../../../models/city_card_model.dart';
import '../../../providers/settings_providers.dart';
import '../../../connections/ssh.dart';

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
    CityCardModel? cityData = ref.watch(cityDataProvider);
    return DashboardRightPanel(
        headers: [TextConst.availableOptions],
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
                  // File file = await SSH(ref: ref).makeFile('Orbit', KMLMakers.buildOrbit(cityData!.location.latitude, cityData.location.longitude));
                  // File file = await SSH(ref: ref).makeFile('Orbit', KMLMakers.buildExample());
                  File file = await SSH(ref: ref).makeFile('Orbit', KMLMakers.buildOrbit(ref));
                  await SSH(ref: ref).kmlFileUpload(file, 'Orbit');
                  await SSH(ref: ref).runKml('Orbit');
                  await SSH(ref: ref).startOrbit();
                } catch (e) {
                  print("EAFDAFASF");
                  print(e);
                }
                ref.read(isLoadingProvider.notifier).state = false;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedTask == 0
                      ? Themes.darkHighlightColor
                      : null,
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
                          size: Const.dashboardTextSize+5,
                          color: Colors.white,
                        ),
                        10.pw,
                        Text(
                          'Play Tour',
                          style: textStyleNormalWhite.copyWith(
                              fontSize:
                              Const.dashboardTextSize + 5),
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
                await SSH(ref: ref).stopOrbit();
                ref.read(isLoadingProvider.notifier).state = false;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: selectedTask == 1
                      ? Themes.darkHighlightColor
                      : null,
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
                          size: Const.dashboardTextSize+5,
                          color: Colors.white,
                        ),
                        10.pw,
                        Text(
                          'Stop Tour',
                          style: textStyleNormalWhite.copyWith(
                              fontSize:
                              Const.dashboardTextSize + 5),
                        ),
                      ],
                    )),
              ),
            ),
          )
        ]);
  }
}
