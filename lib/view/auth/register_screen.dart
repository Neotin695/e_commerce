import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/viewmodel/handling_exception.dart';
import '../../core/viewmodel/auth view model/auth_view_model.dart';

class RegisterScreen extends GetWidget<AuthViewModel> {
  RegisterScreen({super.key});
  final GlobalKey<FormState> _keyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: OfflineBuilder(
        debounceDuration: const Duration(milliseconds: 10),
        connectivityBuilder: ((_, result, child) {
          if (result == ConnectivityResult.none) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/server_down.svg',
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    'No Internet Connection',
                    style:
                        TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          } else {
            return child;
          }
        }),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAuthForm(context),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthForm(BuildContext context) {
    return Form(
      key: _keyLogin,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              Text(
                'Sign in to Continue',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 17.sp,
                ),
              ),
              TextFormField(
                onSaved: (value) {
                  controller.name = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'name is empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 18.sp),
                ),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 3.h),
              TextFormField(
                onSaved: (value) {
                  controller.email = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'email is empty';
                  } else if (!value.isEmail) {
                    return 'invlid email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 18.sp),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 3.h),
              TextFormField(
                onSaved: (value) {
                  controller.password = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'password is empty';
                  } else if (value.length < 8) {
                    return 'password most more than 8 latter';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 18.sp),
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 3.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              _buildCustomButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () => _submit(context),
        child: Container(
          width: 80.w,
          height: 7.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
              child: Text(
            'Sign In',
            style: TextStyle(
                fontSize: 18.sp,
                color: Theme.of(context).colorScheme.onPrimary),
          )),
        ),
      ),
    );
  }

  void _submit(context) {
    if (!_keyLogin.currentState!.validate()) {
      return;
    }
    _keyLogin.currentState!.save();
    controller.createAccount().then((value) {
      ShopingHandler.showSnack(
          title: 'Successfully',
          message: 'We happy to join us',
          type: ContentType.success,
          context: context);
      Get.back;
    }).catchError((e) {
      ShopingHandler.showSnack(
          title: 'Authentication Error',
          message: e.toString(),
          type: ContentType.failure,
          context: context);
    });
  }
}
