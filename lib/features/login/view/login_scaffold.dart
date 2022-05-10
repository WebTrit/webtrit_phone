import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import './login_mode_select_tab.dart';
import './login_otp_request_tab.dart';
import './login_otp_verify_tab.dart';

import '../login.dart';

class LockScaffold extends StatefulWidget {
  const LockScaffold({
    Key? key,
  }) : super(key: key);

  @override
  _LockScaffoldState createState() => _LockScaffoldState();
}

class _LockScaffoldState extends State<LockScaffold> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.tabIndex != current.tabIndex,
      listener: (context, state) {
        _tabController.animateTo(state.tabIndex);
      },
      child: Scaffold(
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              LoginModeSelectTab(),
              LoginOtpRequestTab(),
              LoginOtpVerifyTab(),
            ],
          ),
        ),
      ),
    );
  }
}
