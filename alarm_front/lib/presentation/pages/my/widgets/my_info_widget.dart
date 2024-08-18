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
            print(state.user);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          : Container(
                              width: 70.w,
                              height: 70.w,
                              decoration: BoxDecoration(
                                color: AppColors.receiveMsgBurbleColor,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.person_4_outlined,
                                color: AppColors.hintColor,
                                size: 45.w,
                              ),
                            ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isUpdate
                              ? Container(
                                  width: 140.w,
                                  child: TextField(
                                    controller: _controller,
                                    style: TextStyles.mediumTitle,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        left: 2.w,
                                        right: 2.w,
                                        bottom: 2.h,
                                      ),
                                      isDense: true,
                                    ),
                                  ),
                                )
                              : Text(
                                  state.user.displayName ?? "",
                                  style: TextStyles.mediumTitle,
                                ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Text(
                            state.user.email ?? "",
                            style: TextStyles.mediumText
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
                                ? AppColors.focusColor
                                : AppColors.bottomNavColor,
                            borderRadius: BorderRadius.circular(10.h),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            isUpdate ? "적용" : "수정",
                            style: TextStyles.smallText.copyWith(
                              color: Colors.black,
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
                                  color:
                                      AppColors.countBoxColor.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10.h),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "취소",
                                  style: TextStyles.smallText.copyWith(
                                    fontWeight: FontWeight.w600,
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
