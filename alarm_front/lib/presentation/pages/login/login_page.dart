import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/presentation/bloc/login/login_bloc.dart';
import 'package:alarm_front/presentation/bloc/user/user_bloc.dart';
import 'package:alarm_front/presentation/pages/login/widget/login_button.dart';
import 'package:alarm_front/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(child: Column()),
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
                  logoSize: 20.w,
                  text: "GOOGLE LOGIN",
                  logo: "assets/icons/google.png",
                  onTap: () {
                    context.read<LoginBloc>().add(GoogleLoginEvent());
                  },
                ),
                LoginButton(
                  logoSize: 21.w,
                  text: "KAKAO LOGIN",
                  logo: "assets/icons/kakao.png",
                  color: AppColors.kakaoColor,
                ),
                LoginButton(
                  logoSize: 17.w,
                  text: "NAVER LOGIN",
                  logo: "assets/icons/naver.png",
                  color: AppColors.naverColor,
                ),
                LoginButton(
                  logoSize: 25.w,
                  text: "APPLE LOGIN",
                  logo: "assets/icons/apple.png",
                ),
              ],
            ),
          ),
        )),
      ],
    ));
  }
}
