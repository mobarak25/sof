import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/forgot_password_2/bloc/forgot_password2_bloc.dart';

class ForgotPasswordStep2Screen extends StatelessWidget {
  const ForgotPasswordStep2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final otpFocusNode = FocusNode();
    final usernameFocusNode = FocusNode();
    final newPasswordFocusNode = FocusNode();
    final confirmedPasswordFocusNode = FocusNode();

    final otpController = TextEditingController();
    final usernameController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmedPasswordController = TextEditingController();

    return BlocBuilder<ForgotPassword2Bloc, ForgotPassword2State>(
      builder: (context, state) {
        final bloc = context.read<ForgotPassword2Bloc>();
        return Body(
          appBar: const FutureAppBar(
            title: "Forgot Password",
          ),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: bBlueColor),
                          ),
                          child: const Icon(
                            Icons.mail,
                            size: 50,
                            color: bBlueColor,
                          ),
                        ),
                        const Gap(30),
                        const TextB(
                          text: 'Forget your password?',
                          textStyle: bBody1B,
                        ),
                        const Gap(40),
                        const TextB(
                          text:
                              'To get a new password, fill out the following fields:',
                          alignMent: TextAlign.center,
                          fontColor: bBlack,
                        ),
                        const Gap(40),
                        TextFieldB(
                          paddingHeight: 16,
                          focusNode: otpFocusNode,
                          onChanged: (String otp) {
                            bloc.add(ChangeOtp(otp: otp));
                          },
                          hintText: "Enter OTP",
                          controller: otpController,
                          prefixIcon: Icon(
                            Icons.chat,
                            size: 26,
                            color: usernameFocusNode.hasFocus
                                ? bPrimaryColor
                                : bGray32,
                          ),
                          errorText:
                              state.forms == Forms.invalid && state.otp.isEmpty
                                  ? 'Please enter your otp'
                                  : '',
                        ),
                        const Gap(20),
                        TextFieldB(
                          isMandatory: true,
                          paddingHeight: 16,
                          focusNode: usernameFocusNode,
                          onChanged: (String name) {
                            bloc.add(ChangeUsername(username: name));
                          },
                          hintText: "Enter username",
                          controller: usernameController,
                          prefixIcon: Icon(
                            Icons.assignment_ind,
                            size: 26,
                            color: usernameFocusNode.hasFocus
                                ? bPrimaryColor
                                : bGray32,
                          ),
                          errorText: state.forms == Forms.invalid &&
                                  state.username.isEmpty
                              ? 'Please enter your username'
                              : '',
                        ),
                        const Gap(20),
                        TextFieldB(
                          isMandatory: true,
                          paddingHeight: 16,
                          focusNode: newPasswordFocusNode,
                          obscureText: state.isObscureTextNP,
                          onChanged: (String newPassword) {
                            bloc.add(
                                ChangeNewPassword(newPassword: newPassword));
                          },
                          hintText: "Enter New password",
                          controller: newPasswordController,
                          prefixIcon: Icon(
                            Icons.lock,
                            size: 26,
                            color: usernameFocusNode.hasFocus
                                ? bPrimaryColor
                                : bGray32,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              bloc.add(ChangeisObscureTextNP());
                            },
                            child: state.isObscureTextNP
                                ? const Icon(
                                    Icons.visibility,
                                    size: 25,
                                    color: bGray32,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    size: 25,
                                    color: bGray32,
                                  ),
                          ),
                          errorText: state.forms == Forms.invalid &&
                                  state.username.isEmpty
                              ? 'Please enter new password'
                              : '',
                        ),
                        const Gap(20),
                        TextFieldB(
                          isMandatory: true,
                          paddingHeight: 16,
                          focusNode: confirmedPasswordFocusNode,
                          obscureText: state.isObscureTextCP,
                          onChanged: (String confirmedPassword) {
                            bloc.add(ChangeConfirmePassword(
                                confirmePassword: confirmedPassword));
                          },
                          hintText: "Enter Confirme password",
                          controller: confirmedPasswordController,
                          prefixIcon: Icon(
                            Icons.lock,
                            size: 26,
                            color: usernameFocusNode.hasFocus
                                ? bPrimaryColor
                                : bGray32,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              bloc.add(ChangeisObscureTextCP());
                            },
                            child: state.isObscureTextCP
                                ? const Icon(
                                    Icons.visibility,
                                    size: 25,
                                    color: bGray32,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    size: 25,
                                    color: bGray32,
                                  ),
                          ),
                          errorText: state.forms == Forms.invalid &&
                                  state.username.isEmpty
                              ? 'Please enter confirme password'
                              : '',
                        ),
                        const Gap(40),
                        ButtonB(
                          heigh: 55,
                          text: "Send",
                          fontSize: 16,
                          loading: state.loading,
                          fontWeight: FontWeight.w600,
                          textColor: bWhite,
                          press: () {
                            bloc.add(PressToSend(
                              otpFocusNode: otpFocusNode,
                              usernameFocusNode: usernameFocusNode,
                              newPasswordFocusNode: newPasswordFocusNode,
                              confirmedPasswordFocusNode:
                                  confirmedPasswordFocusNode,
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
