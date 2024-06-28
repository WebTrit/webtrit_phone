import 'package:flutter/material.dart';

const kApiClientConnectionTimeout = Duration(seconds: 5);

const kSignalingClientConnectionTimeout = Duration(seconds: 10);
const kSignalingClientReconnectDelay = Duration(seconds: 3);
const kSignalingClientFastReconnectDelay = Duration(seconds: 1);

const kCompatibilityVerifyRepeatDelay = Duration(seconds: 2);

const kDebounceDuration = Duration(milliseconds: 275);

const kInset = kMinInteractiveDimension / 2;

const kMainAppBarBottomTabHeight = 42.0;
const kMainAppBarBottomSearchHeight = kMinInteractiveDimension;
const kMainAppBarBottomPaddingGap = 6.0;

const kAllPadding16 = EdgeInsets.all(16.0);

const kBlankUri = 'about:blank';

const initialMainRout = '/main';
const initialCallRout = '/main/call';

const kAutoprovisionRout = '/autoprovision';

const loginModeScreenSignUpButtonKey = 'loginModeScreenSignUpButton';
const loginModeScreenUrlButtonKey = 'loginModeScreenUrlButton';

const coreUrlInputKey = 'coreUrlInput';
const coreUrlButtonKey = 'coreUrlButton';

const signupEmailInputKey = 'signupEmailInput';
const signupVerifyInputKey = 'signupVerifyInput';
const signupEmailButtonKey = 'signupEmailButton';
const signupVerifyButtonKey = 'signupVerifyButton';

const optInputKey = 'otpInput';
const otpVerifyInputKey = 'otpVerifyInput';
const otpButtonKey = 'otpButton';
const otpVerifyButtonKey = 'otpVerifyButton';

const passwordUserInputKey = 'passwordUserInput';
const passwordPasswordInputKey = 'passwordPasswordInput';
const passwordButtonKey = 'passwordButton';
