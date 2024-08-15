import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/presentation/bloc/login/login_bloc.dart';
import 'package:alarm_front/presentation/pages/login/widget/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        )),
      ],
    ));
  }
}
