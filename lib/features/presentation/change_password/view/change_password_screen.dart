import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/change_password/bloc/change_password_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final currentPasswordFocusNode = FocusNode();
  final newPasswordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        final top = MediaQuery.of(context).padding.top;
        final bloc = context.read<ChangePasswordBloc>();
        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(title: LocaleKeys.changePas.tr()),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, top, 15, 0),
            decoration: const BoxDecoration(
              color: Color(0XFFF9F9FF),
              image: DecorationImage(
                image: AssetImage(loginBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: bBlueColor),
                            ),
                            child: const Icon(
                              Icons.lock,
                              size: 80,
                              color: bBlueColor,
                            ),
                          ),
                          const SizedBox(height: 60),
                          TextFieldB(
                            fieldTitle: LocaleKeys.curPass.tr(),
                            isMandatory: true,
                            paddingHeight: 16,
                            focusNode: currentPasswordFocusNode,
                            onChanged: (String currentPassword) {
                              bloc.add(ChangeCurrentPassword(
                                  currentPassword: currentPassword));
                            },
                            hintText: LocaleKeys.enterCurPass.tr(),
                            controller: currentPasswordController,
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 26,
                              color: currentPasswordFocusNode.hasFocus
                                  ? bGreen
                                  : bGray32,
                            ),
                            errorText: state.forms == Forms.invalid &&
                                    state.currentPassword.isEmpty
                                ? LocaleKeys.curPasEmpty.tr()
                                : '',
                          ),
                          const Gap(20),
                          TextFieldB(
                            fieldTitle: LocaleKeys.newPass.tr(),
                            isMandatory: true,
                            paddingHeight: 16,
                            focusNode: newPasswordFocusNode,
                            onChanged: (String newPassword) {
                              bloc.add(
                                  ChangeNewPassword(newPassword: newPassword));
                            },
                            hintText: LocaleKeys.enterNewPas.tr(),
                            controller: newPasswordController,
                            prefixIcon: Icon(
                              Icons.assignment_ind,
                              size: 26,
                              color: newPasswordFocusNode.hasFocus
                                  ? bGreen
                                  : bGray32,
                            ),
                            errorText: state.forms == Forms.invalid &&
                                    state.newPassword.isEmpty
                                ? LocaleKeys.newPasEmpty.tr()
                                : '',
                          ),
                          const SizedBox(height: 20),
                          TextFieldB(
                            paddingHeight: 16,
                            isMandatory: true,
                            focusNode: confirmPasswordFocusNode,
                            controller: confirmPasswordController,
                            onChanged: (String confirmpassword) {
                              bloc.add(ChangeConfirmPassword(
                                  confirmPassword: confirmpassword));
                            },
                            fieldTitle: LocaleKeys.confirmPas.tr(),
                            hintText: LocaleKeys.enterConfirmPas.tr(),
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 26,
                              color: confirmPasswordFocusNode.hasFocus
                                  ? bGreen
                                  : bGray32,
                            ),
                            errorText: state.forms == Forms.invalid &&
                                    state.confirmePassword.isEmpty
                                ? LocaleKeys.conPasEmpty.tr()
                                : '',
                          ),
                          const SizedBox(height: 40),
                          ButtonB(
                            heigh: 55,
                            text: LocaleKeys.changePas.tr(),
                            fontSize: 16,
                            loading: state.loading,
                            fontWeight: FontWeight.w600,
                            textColor: bWhite,
                            press: () {
                              bloc.add(PressToChangePassword(
                                  currentPassword: currentPasswordFocusNode,
                                  newPassword: newPasswordFocusNode,
                                  confirmPassword: confirmPasswordFocusNode));
                            },
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
