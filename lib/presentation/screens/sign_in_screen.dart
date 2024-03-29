import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tap_cash/controller/sign_in_cubit.dart';
import 'package:tap_cash/controller/sign_in_state.dart';
import 'package:tap_cash/core/components/buttons.dart';
import 'package:tap_cash/core/components/navigator.dart';
import 'package:tap_cash/core/components/sized_box.dart';
import 'package:tap_cash/core/components/text_form_field.dart';
import 'package:tap_cash/core/theme/app_color/app_color_light.dart';
import 'package:tap_cash/generated/assets.dart';
import 'package:tap_cash/presentation/screens/forget_password_screen.dart';
import 'package:tap_cash/presentation/screens/otp_sign_in_screen.dart';
import 'package:tap_cash/presentation/screens/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          // if (state is SignInSuccessState) {
          //   if (state.signInModel.status!) {
          //     showToast(
          //       text: state.signInModel.message!,
          //       state: ToastStates.success,
          //     );
          //     print(state.signInModel.message);
          //     print(state.signInModel.token);
          //
          //     CacheHelper.saveData(
          //         key: "token", value: state.signInModel.token)
          //         .then((value) {
          //     uId = state.signInModel.token!;
          //       navigateAndFinish(context, const HomeScreen());
          //     });
          //   } else {
          //     showToast(
          //       text: state.signInModel.message!,
          //       state: ToastStates.error,
          //     );
          //     print(state.signInModel.message);
          //   }
          // }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 167.h,
              leading: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                      height: 175.h,
                      width: double.infinity,
                      color: const Color(0xFFD4EEDD),
                      child: SvgPicture.asset(Assets.imagesLoginBackGround)),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 12),
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
                            color: AppColors.primaryColor,
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              leadingWidth: double.infinity,
            ),
            body: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Phone Number',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.primaryColor,
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Space(height: 2, width: 0),
                                DefaultTextFormField(
                                  context: context,
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  hint: '01234567892',
                                  validate: (String? value) {
                                    if (value!.isEmpty ||
                                        value.length < 11 ||
                                        value.length > 11) {
                                      return 'An Egyptian phone number consisting of 11 digits';
                                    }
                                    return null;
                                  },
                                ),
                                const Space(height: 12, width: 0),
                                Text(
                                  'Password',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.primaryColor,
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Space(height: 2, width: 0),
                                DefaultTextFormField(
                                  context: context,
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  hint: 'Tap12345@',
                                  suffix: SignInCubit.get(context).suffix,
                                  isPassword:
                                      SignInCubit.get(context).isPassword,
                                  suffixPressed: () {
                                    SignInCubit.get(context).changePassword();
                                  },
                                  validate: (String? value) {
                                    RegExp regex = RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                    if (value!.trim().isEmpty ||
                                        value.trim().length < 8 ||
                                        !regex.hasMatch(value)) {
                                      return 'Uppercase and lowercase letters, numbers and signs, and not less than 8 letters';
                                    }
                                    return null;
                                  },
                                ),
                                const Space(height: 5, width: 0),
                                InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context, const ForgetPasswordScreen());
                                  },
                                  child: Text(
                                    'Forget Password?',
                                    style: GoogleFonts.poppins(
                                      color: AppColors.greyColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const Space(height: 29, width: 0),
                                defaultMaterialButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      SignInCubit.get(context)
                                          .otpAuthentications(
                                        phoneNumber: phoneController.text,
                                      );
                                      navigateTo(
                                        context,
                                        OtpSignInScreen(
                                          phoneNumber: phoneController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                    }
                                  },
                                  text: 'Sign In',
                                  color: AppColors.primaryColor,
                                ),
                                Space(height: 90.h, width: 0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account?',
                                      style: GoogleFonts.poppins(
                                        color: AppColors.blackColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Space(height: 0, width: 5),
                                    InkWell(
                                      onTap: () {
                                        navigateTo(
                                            context, const SignUpScreen());
                                      },
                                      child: Text(
                                        'Sign Up',
                                        style: GoogleFonts.poppins(
                                          color: AppColors.primaryColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
