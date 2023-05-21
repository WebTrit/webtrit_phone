import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/routes.dart';

import '../login.dart';
import 'login_mode_select_tab.dart';
import 'login_core_url_assign_tab.dart';
import 'login_otp_request_tab.dart';
import 'login_otp_verify_tab.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(
    this.step, {
    super.key,
  });

  final LoginStep step;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.step.index,
      length: LoginStep.values.length,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(LoginScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _tabController.animateTo(widget.step.index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.step != current.step,
      listener: (context, state) {
        context.goNamed(AppRoute.loginStep, pathParameters: {
          LoginStep.pathParameterName: state.step.name,
        });
      },
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          LoginModeSelectTab(),
          LoginCoreUrlAssignTab(),
          LoginOtpRequestTab(),
          LoginOtpVerifyTab(),
        ],
      ),
    );
  }
}
