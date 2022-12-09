import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/routes.dart';

import './login_mode_select_tab.dart';
import './login_core_url_assign_tab.dart';
import './login_otp_request_tab.dart';
import './login_otp_verify_tab.dart';

import '../login.dart';

class LoginTabs extends StatefulWidget {
  const LoginTabs(
    this.step, {
    super.key,
  });

  final LoginStep step;

  @override
  State<LoginTabs> createState() => _LoginTabsState();
}

class _LoginTabsState extends State<LoginTabs> with SingleTickerProviderStateMixin {
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
  void didUpdateWidget(LoginTabs oldWidget) {
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
        context.goNamed(AppRoute.loginStep, params: {'$LoginStep': state.step.name});
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
