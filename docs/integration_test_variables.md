# Integration Test Variables

## Login methods / default login settings

*Email login: (optional)* 
* `WEBTRIT_APP_TEST_EMAIL_CREDENTIAL` (_example myaccount@mail.com_)
* `WEBTRIT_APP_TEST_EMAIL_VERIFY_CREDENTIAL` (_example 123456_)

*OTP login: (optional)* 
* `WEBTRIT_APP_TEST_OTP_CREDENTIAL` (_example +1234566789_)
* `WEBTRIT_APP_TEST_OTP_VERIFY_CREDENTIAL` (_example 123456_)

*Password login: (optional)* 
* `WEBTRIT_APP_TEST_PASSWORD_USER_CREDENTIAL`  (_example username_)
* `WEBTRIT_APP_TEST_PASSWORD_PASSWORD_CREDENTIAL` (_example 123456_)

*Custom core url, if not defined default signin button will be used*
* `WEBTRIT_APP_TEST_CUSTOM_CORE_URL` (_example core.demo.mycompany.com_)

*Login method that will be used for other tests*
* `WEBTRIT_APP_TEST_DEFAULT_LOGIN_METHOD` -  (_email_ | _password_ | _otp_)

## Contacts and favorites tests

*Search query that must match **more than one** external contact*
* `WEBTRIT_APP_TEST_EXT_CONTACT_MULTI_SEARCH_QUERY` (_example Doe_)

*Unique name query matches **exactly one** external contact but doesn't match another*
* `WEBTRIT_APP_TEST_EXT_CONTACT_A_UNIQUE_NAME` (_example John_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_B_UNIQUE_NAME` (_example Jane_)

*Phone number of that contact _(optional in contact details test — verification skipped if empty)_*
* `WEBTRIT_APP_TEST_EXT_CONTACT_A_UNIQUE_NUMBER` (_example 00111_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_B_UNIQUE_NUMBER` (_example 00222_)

*Phone number with label `ext` in that contact's detail _(optional — verification skipped if empty)_*
* `WEBTRIT_APP_TEST_EXT_CONTACT_A_UNIQUE_EXT_NUMBER` (_example 00114_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_B_UNIQUE_EXT_NUMBER` (_example 00225_)

*Phone number with label `additional` in that contact's detail _(optional — verification skipped if empty)_*
* `WEBTRIT_APP_TEST_EXT_CONTACT_A_UNIQUE_ADDITIONAL_NUMBER` (_example 00112_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_B_UNIQUE_ADDITIONAL_NUMBER` (_example 00223_)

*Phone number with label `sms` in that contact's detail _(optional — verification skipped if empty)_*
* `WEBTRIT_APP_TEST_EXT_CONTACT_A_UNIQUE_SMS_NUMBER` (_example 00113_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_B_UNIQUE_SMS_NUMBER` (_example 00224_)

*Email address in that contact's detail _(optional — verification skipped if empty)_*
* `WEBTRIT_APP_TEST_EXT_CONTACT_A_UNIQUE_EMAIL` (_example user.a@example.com_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_B_UNIQUE_EMAIL` (_example user.b@example.com_)

*SIP credentials used by pjsua companion to place/receive calls on behalf of that contact*
* `WEBTRIT_APP_TEST_EXT_CONTACT_A_SIP_USERNAME` (_example 00111_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_A_SIP_PASSWORD` (_example 00111PWD_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_B_SIP_USERNAME` (_example 00222_)
* `WEBTRIT_APP_TEST_EXT_CONTACT_B_SIP_PASSWORD` (_example 00222PWD_)

## User info tests

*Name that should be displayed in account info section*
* `WEBTRIT_APP_TEST_ACCOUNT_NAME` (_example Test Account_)

*Main number that should be displayed in account info section*
* `WEBTRIT_APP_TEST_ACCOUNT_MAIN_NUMBER` (_example 1230000_)

## Calls tests

* `WEBTRIT_APP_TEST_CROSS_CALL_SLEEP_SECONDS` (_example 10_)

*PJSUA server host, if not defined `localhost`*
* `WEBTRIT_APP_TEST_PJSUA_SERVER_HOST` (_example localhost_)

*PJSUA server port, if not defined `7788`*
* `WEBTRIT_APP_TEST_PJSUA_SERVER_PORT` (_example 7788_)

* `WEBTRIT_APP_TEST_PJSUA_SIP_SERVER` (_example server_)
