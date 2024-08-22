import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:alarm_front/presentation/bloc/login/login_bloc.dart';
import 'package:alarm_front/presentation/bloc/user/user_bloc.dart';
import 'package:alarm_front/presentation/pages/login/widget/login_button.dart';
import 'package:alarm_front/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.focusPurpleColor,
        body: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80.w,
                ),
                SizedBox(
                  width: 180.w,
                  height: 180.w,
                  child: Container(
                    child: Center(
                      child: Image.asset('assets/images/topk_logo.png'),
                    ),
                  ),
                ),
              ],
            )),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: MultiBlocListener(
                listeners: [
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        context
                            .read<UserBloc>()
                            .add(UserAuthenticated(user: state.user));
                      }
                      if (state is LoginFailure) {
                        showCustomSnackbar(context, "로그인을 다시 해주세요.");
                      }
                    },
                  ),
                  BlocListener<UserBloc, UserState>(
                    listener: (context, state) async {
                      if (state is GetUserSuccess) {
                        context.goNamed("roomList");
                      }

                      if (state is GetUserError) {
                        print(state.message);
                        showCustomSnackbar(
                          context,
                          "잠시 후에 다시 시도해 주세요.",
                        );
                      }
                    },
                  ),
                ],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginButton(
                      logoSize: 21.w,
                      text: "구글로 시작하기",
                      textStyle: TextStyles.loginButton.copyWith(),
                      logo: "assets/icons/google.png",
                      bgColor: AppColors.googleBgColor,
                      onTap: () {
                        context.read<LoginBloc>().add(GoogleLoginEvent());
                      },
                    ),
                    LoginButton(
                      logoSize: 21.w,
                      text: "카카오로 시작하기",
                      textStyle: TextStyles.loginButton.copyWith(),
                      logo: "assets/icons/kakao.png",
                      bgColor: AppColors.kakaoBgColor,
                      color: AppColors.kakaoColor,
                      onTap: () {
                        context.read<LoginBloc>().add(KakaoLoginEvent());
                      },
                    ),
                    LoginButton(
                      logoSize: 20.w,
                      text: "네이버로 시작하기",
                      textStyle: TextStyles.loginButtonWhite.copyWith(),
                      logo: "assets/icons/naver.png",
                      bgColor: AppColors.naverBgColor,
                      color: AppColors.naverColor,
                    ),
                    LoginButton(
                      logoSize: 21.w,
                      text: "페이스북으로 시작하기",
                      textStyle: TextStyles.loginButtonWhite.copyWith(),
                      logo: "assets/icons/facebook.png",
                      bgColor: AppColors.facebookBgColor,
                      onTap: () {
                        context.read<LoginBloc>().add(FacebookLoginEvent());
                      },
                    ),
                  ],
                ),
              ),
            )),
          ],
        ));
  }
}
