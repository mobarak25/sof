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
import 'package:school_of_future/features/presentation/forgot_password_1/bloc/forgot_password_bloc.dart';

class ForgotPasswordStep1Screen extends StatelessWidget {
  const ForgotPasswordStep1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final usernameFocusNode = FocusNode();
    final usernameController = TextEditingController();
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        final bloc = context.read<ForgotPasswordBloc>();
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
                              'Enter your username below to receive your password\n reset instructions',
                          alignMent: TextAlign.center,
                          fontColor: bBlack,
                        ),
                        const Gap(40),
                        TextFieldB(
                          fieldTitle: "Username",
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
                        const Gap(40),
                        ButtonB(
                          heigh: 55,
                          text: "Send otp",
                          fontSize: 16,
                          loading: state.loading,
                          fontWeight: FontWeight.w600,
                          textColor: bWhite,
                          press: () {
                            bloc.add(PressToOtp(
                              usernameFocusNode: usernameFocusNode,
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
