import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_city_dashboard/constants/text_styles.dart';
import 'package:smart_city_dashboard/models/forecast_weather.dart';
import 'package:smart_city_dashboard/models/realtime_weather.dart';
import 'package:smart_city_dashboard/providers/page_providers.dart';
import 'package:smart_city_dashboard/services/weather_api.dart';
import 'package:smart_city_dashboard/widgets/extensions.dart';
import 'package:smart_city_dashboard/widgets/helper.dart';
import 'package:smart_city_dashboard/widgets/logo_shower.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../constants/constants.dart';
import '../../constants/texts.dart';
import '../../constants/theme.dart';
import '../../providers/settings_providers.dart';
import '../../ssh_lg/ssh.dart';

class DashboardContainer extends StatefulWidget {
  const DashboardContainer(
      {super.key,
      this.heightMultiplier = 1,
      this.widthMultiplier = 1,
      this.showPercentage = false,
      this.progressColor = Colors.transparent,
      required this.title,
      required this.data,
      required this.image});
  final double heightMultiplier;
  final double widthMultiplier;
  final bool showPercentage;
  final Color progressColor;
  final String title;
  final String data;
  final ImageProvider<Object> image;

  @override
  State<DashboardContainer> createState() => _DashboardContainerState();
}

class _DashboardContainerState extends State<DashboardContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (screenSize(context).width - Const.tabBarWidth) *
              widget.widthMultiplier /
              4 -
          (widget.widthMultiplier - 2).abs() * Const.dashboardUISpacing / 2,
      height: (screenSize(context).width - Const.tabBarWidth) *
          widget.heightMultiplier *
          Const.dashboardUIHeightFactor /
          4,
      decoration: BoxDecoration(
        color: Themes.darkHighlightColor,
        borderRadius: BorderRadius.circular(Const.dashboardUIRoundness),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: textStyleNormal.copyWith(
                  fontSize: 20, color: Colors.white.withOpacity(0.7)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.showPercentage
                    ? CircularPercentIndicator(
                        radius: 40.0,
                        lineWidth: 10.0,
                        animation: true,
                        percent: 0.7,
                        center: LogoShower(logo: widget.image, size: 45),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: widget.progressColor,
                  backgroundColor: lightenColor(Themes.darkHighlightColor, 0.1),
                      )
                    : LogoShower(logo: widget.image, size: 65),
                15.pw,
                Text(
                  widget.data,
                  style: textStyleBoldWhite.copyWith(fontSize: 40),
                ),
              ],
            ),
            const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
