import 'package:flutter/material.dart';

import 'package:news_wave/presentation/utils/extensions/color_extension.dart';

import '../../managers/injection_container.dart';
import '../../managers/local_storage_manager.dart';
import '../../utils/colors/color_coding.dart';
import '../../utils/constants/strings.dart';
import '../../utils/helpers/routes/custom_routes.dart';
import '../../utils/responsive/screen_sizes.dart';
import '../../widgets/custom_text_field.dart';
import '../notification_screen/notification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();

  final TextEditingController _lastNameController = TextEditingController();
  final FocusNode _lastNameFocusNode = FocusNode();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = displayHeight(context);
    double screenWidth = displayWidth(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.07,
                  right: screenWidth * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loginScreenTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: titleColor.toColor(),
                        fontSize: screenHeight * 0.03),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.03),
                    child: Text(
                      loginScreenSubTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: subTitleColor.toColor(),
                          fontSize: screenHeight * 0.018),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.04),
                    child: CustomTextField(
                      controller: _firstNameController,
                      focusNode: _firstNameFocusNode,
                      hintText: firstNameHintText,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.03),
                    child: CustomTextField(
                      controller: _lastNameController,
                      focusNode: _lastNameFocusNode,
                      hintText: lastNameHintText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: ValueListenableBuilder<TextEditingValue>(
          valueListenable: _firstNameController,
          builder: (context, firstNameValue, child) {
            return ValueListenableBuilder<TextEditingValue>(
              valueListenable: _lastNameController,
              builder: (context, lastNameValue, child) {
                bool isButtonEnabled = firstNameValue.text.isNotEmpty &&
                    lastNameValue.text.isNotEmpty;

                return FloatingActionButton(
                  onPressed: isButtonEnabled
                      ? () async {
                          await getIt<SharedPreferencesService>()
                              .saveFirstName(_firstNameController.text);

                          await getIt<SharedPreferencesService>()
                              .saveLastName(_lastNameController.text);

                          Navigator.push(
                              context,
                              createRoute(const NotificationScreen()));
                        }
                      : null,
                  backgroundColor: isButtonEnabled
                      ? enableButtonBackgroundColor.toColor()
                      : disableButtonBackgroundColor.toColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: vectorColor.toColor(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
