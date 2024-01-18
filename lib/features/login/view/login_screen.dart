import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_mode_select_tab.dart';
import 'login_core_url_assign_tab.dart';
import 'login_otp_request_tab.dart';
import 'login_otp_verify_tab.dart';

import '../login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen(
    this.step, {
    super.key,
    this.appGreeting,
  });

  final LoginStep step;

  final String? appGreeting;

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
        if (_tabController.index != state.step.index) {
          _tabController.animateTo(state.step.index);
        }
      },
      child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          LoginModeSelectTab(
            appGreeting: widget.appGreeting,
          ),
          const LoginCoreUrlAssignTab(),
          const LoginOtpRequestTab(),
          const LoginOtpVerifyTab(),
        ],
      ),
    );
  }
}
