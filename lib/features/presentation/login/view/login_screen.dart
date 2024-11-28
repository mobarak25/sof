import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final usernameFocusController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final top = MediaQuery.of(context).padding.top;
        final bloc = context.read<LoginBloc>();
        return Body(
          isFullScreen: true,
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
                            width: 200,
                            height: 110,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/classtune_logo_third.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: null,
                          ),
                          const SizedBox(height: 40),
                          const TextB(
                            text: "Sign In To Your Account",
                            textStyle: bBody1M,
                            fontColor: bGray100,
                            alignMent: TextAlign.center,
                          ),
                          const SizedBox(height: 60),
                          TextFieldB(
                            fieldTitle: "Username",
                            isMandatory: true,
                            paddingHeight: 16,
                            focusNode: usernameFocusNode,
                            onChanged: (String name) {
                              bloc.add(ChangeUserName(userName: name));
                            },
                            hintText: "Enter username",
                            controller: usernameFocusController,
                            prefixIcon: Icon(
                              Icons.assignment_ind,
                              size: 26,
                              color:
                                  usernameFocusNode.hasFocus ? bGreen : bGray32,
                            ),
                            errorText: state.forms == Forms.invalid &&
                                    state.userName.isEmpty
                                ? 'Please Enter Your Username'
                                : '',
                          ),
                          const SizedBox(height: 30),
                          TextFieldB(
                            paddingHeight: 16,
                            focusNode: passwordFocusNode,
                            controller: passwordController,
                            onChanged: (String password) {
                              bloc.add(ChangePassword(password: password));
                            },
                            obscureText: state.isObscureText,
                            fieldTitle: "Password",
                            hintText: "Enter password",
                            prefixIcon: Icon(
                              Icons.lock,
                              size: 26,
                              color:
                                  passwordFocusNode.hasFocus ? bGreen : bGray32,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                bloc.add(IsObscureText());
                              },
                              child: TextB(
                                text: state.isObscureText ? "Show" : "Hide",
                              ),
                            ),
                            errorText: state.forms == Forms.invalid &&
                                    state.password.isEmpty
                                ? 'Please Enter Your Password'
                                : '',
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, forgotPasswordStep1);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: TextB(
                                    text: "Forgot Password ?",
                                    textStyle: bBody2M,
                                    fontColor: bJungleGreen,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          ButtonB(
                            heigh: 55,
                            text: "Sign In",
                            fontSize: 16,
                            loading: state.loading,
                            fontWeight: FontWeight.w600,
                            textColor: bWhite,
                            press: () {
                              bloc.add(PressToLogin(
                                userNameFocusNode: usernameFocusNode,
                                passwordFocusNode: passwordFocusNode,
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
          ),
        );
      },
    );
  }
}
