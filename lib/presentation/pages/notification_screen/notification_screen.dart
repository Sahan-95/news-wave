import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'package:news_wave/presentation/utils/extensions/color_extension.dart';

import '../../managers/permission_handler_helper.dart';
import '../../utils/colors/color_coding.dart';
import '../../utils/constants/strings.dart';
import '../../utils/responsive/screen_sizes.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = displayHeight(context);
    double screenWidth = displayWidth(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.07, right: screenWidth * 0.07),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/notification_screen/message-notif.svg",
                      fit: BoxFit.fill,
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(subContentTitle,
                              style: TextStyle(
                                  color: subContentTitleColor.toColor(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: screenHeight * 0.025)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: Text(subContent,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: subTitleColor.toColor(),
                              fontWeight: FontWeight.w400,
                              fontSize: screenHeight * 0.015)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                child: SizedBox(
                    width: screenWidth * 0.86,
                    child: ElevatedButton(
                        onPressed: () async {
                          // Request notification permission
                          await GetIt.instance<PermissionHandlingHelper>()
                              .requestNotificationPermission(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              enableButtonBackgroundColor.toColor(),
                          foregroundColor: vectorColor.toColor(),
                        ),
                        child: Text(buttonText))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
