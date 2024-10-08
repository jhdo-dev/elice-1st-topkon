import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:alarm_front/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:alarm_front/presentation/bloc/user/user_bloc.dart';
import 'package:alarm_front/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MyInfoWidget extends StatefulWidget {
  const MyInfoWidget({
    super.key,
  });

  @override
  State<MyInfoWidget> createState() => _MyInfoWidgetState();
}

class _MyInfoWidgetState extends State<MyInfoWidget> {
  bool isUpdate = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserBloc, UserState>(
      listener: (context, state) {
        if (state is UpdateUserSuccess) {
          showCustomSnackbar(context, "닉네임이 수정되었습니다.");

          setState(() {
            isUpdate = false;
          });
        }
        if (state is UpdateUserError) {
          showCustomSnackbar(context, "닉네임을 수정할 수 없습니다.");
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is GetUserSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (state.user.photoUrl != null && state.user.photoUrl != "")
                          ? ClipOval(
                              child: Container(
                                width: 60.w,
                                height: 60.h,
                                child: Image.network(
                                  state.user.photoUrl!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : ClipOval(
                              child: Container(
                                width: 60.w,
                                height: 60.h,
                                child: Image.asset(
                                  'assets/images/topk_default_profile.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isUpdate
                              ? Container(
                                  width: 140.w,
                                  height: 35.h,
                                  child: TextField(
                                    controller: _controller,
                                    style: TextStyles.largeTitle,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        top: 0,
                                        right: 2.w,
                                        bottom: 2.h,
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 35.h,
                                  alignment: Alignment.center,
                                  child: Text(
                                    state.user.displayName ?? "",
                                    style: TextStyles.largeTitle,
                                  ),
                                ),
                          if (state.user.email != null &&
                              state.user.email != "")
                            Text(
                              state.user.email!,
                              style: TextStyles.smallText
                                  .copyWith(color: AppColors.hintColor),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!isUpdate && state.user.displayName != null) {
                            _controller.text = state.user.displayName!;
                          }
                          if (isUpdate) {
                            if (_controller.text.isEmpty) {
                              showCustomSnackbar(context, "닉네임을 입력해 주세요.");
                            } else if (state.user.uuid == null) {
                              showCustomSnackbar(context, "닉네임을 수정할 수 없습니다.");
                            } else {
                              context.read<UpdateUserBloc>().add(
                                    UserUpdateEvent(
                                      uuid: state.user.uuid!,
                                      name: _controller.text,
                                    ),
                                  );
                            }
                          }
                          setState(() {
                            isUpdate = true;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: 70.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: isUpdate
                                ? AppColors.focusPurpleColor
                                : AppColors.bottomNavColor,
                            borderRadius: BorderRadius.circular(10.h),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            isUpdate ? "적용" : "수정",
                            style: TextStyles.smallText.copyWith(
                              color: isUpdate
                                  ? AppColors.appbarColor
                                  : AppColors.backgroundColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      isUpdate
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isUpdate = false;
                                });
                              },
                              child: Container(
                                width: 70.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  color: AppColors.appbarColor,
                                  borderRadius: BorderRadius.circular(10.h),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "취소",
                                  style: TextStyles.smallText.copyWith(
                                    color: AppColors.countBoxColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                context.read<UserBloc>().add(UserLoggedOut());
                                context
                                    .read<BottomNavBloc>()
                                    .add(SelectItem(selectedIndex: 0));
                                context.goNamed("login");
                              },
                              child: Container(
                                width: 70.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  color: AppColors.receiveMsgBurbleColor,
                                  borderRadius: BorderRadius.circular(10.h),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "로그아웃",
                                  style: TextStyles.smallText.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
