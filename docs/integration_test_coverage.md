# Integration Test Coverage

All tests live in the `patrol_test/` directory and are built on the [Patrol](https://patrol.dev/) framework.
Each test bootstraps the full app, logs in (or reuses an existing session), performs its scenario, and tears down cleanly.

---

## Login

**File:** `patrol_test/login_system_test.dart`

Three independent tests — each skipped automatically if the required credentials are absent in the environment.

| Test | Credential variables required |
|------|-------------------------------|
| Login by email | `WEBTRIT_APP_TEST_EMAIL_CREDENTIAL`, `WEBTRIT_APP_TEST_EMAIL_VERIFY_CREDENTIAL` |
| Login by OTP | `WEBTRIT_APP_TEST_OTP_CREDENTIAL`, `WEBTRIT_APP_TEST_OTP_VERIFY_CREDENTIAL` |
| Login by password | `WEBTRIT_APP_TEST_PASSWORD_USER_CREDENTIAL`, `WEBTRIT_APP_TEST_PASSWORD_PASSWORD_CREDENTIAL` |

**Steps (shared structure):**
1. Bootstrap app and wait for `AppShell`.
2. Optionally navigate to a custom core URL (`WEBTRIT_APP_TEST_CUSTOM_CORE_URL`).
3. Enter credentials for the chosen method and confirm.
4. Accept agreements and permissions until `MainShell` is visible.
5. Wait 5 seconds on the main screen.
6. Log out and verify return to `LoginModeSelectScreen`.

---

## Profile & SIP Registration

**File:** `patrol_test/profile_and_registration_test.dart`

**Verifies:** Account info is displayed correctly and SIP re-registration works.

**Steps:**
1. Log in if needed.
2. Open the profile screen via the main app bar.
3. Verify account name (`WEBTRIT_APP_TEST_ACCOUNT_NAME`) appears in `UserInfoListTile`.
4. Verify main number (`WEBTRIT_APP_TEST_ACCOUNT_MAIN_NUMBER`) appears in `UserInfoListTile`.
5. Verify `SessionStatus` shows `CallStatus.ready` (registered).
6. Toggle the registration `SwitchListTile` off — verify status changes to `CallStatus.appUnregistered`.
7. Toggle it back on — verify status returns to `CallStatus.ready`.

---

## Contacts — External Tab

**File:** `patrol_test/contacts_ext_tab_test.dart`

**Verifies:** Contact search and tab navigation in the PBX contacts screen.

**Steps:**
1. Log in if needed.
2. Navigate to the Contacts tab.
3. Switch between local and external contact tabs.
4. Search with `WEBTRIT_APP_TEST_EXT_CONTACT_MULTI_SEARCH_QUERY` — verify more than one result appears.
5. Search by `WEBTRIT_APP_TEST_EXT_CONTACT_A_UNIQUE_NAME` — verify only contact A appears.
6. Search by `WEBTRIT_APP_TEST_EXT_CONTACT_A_UNIQUE_NUMBER` — verify only contact A appears.
7. Search by `WEBTRIT_APP_TEST_EXT_CONTACT_B_UNIQUE_NAME` — verify only contact B appears.
8. Search by `WEBTRIT_APP_TEST_EXT_CONTACT_B_UNIQUE_NUMBER` — verify only contact B appears.

---

## Contacts — Detail View

**File:** `patrol_test/contacts_details_test.dart`

**Verifies:** Contact detail fields are shown correctly and calling from a contact works.

**Steps (repeated for contact A and contact B):**
1. Log in if needed.
2. Navigate to Contacts → External tab.
3. Search for the contact if not already visible.
4. Tap the contact tile to open the detail view.
5. Verify ext number, main number, additional number, SMS number, and email address are displayed (fields are optional — skipped if the corresponding variable is empty).
6. Initiate a call from the detail view and verify it connects.
7. Navigate back to the contacts list.

---

## Favorites

**File:** `patrol_test/favorites_tab_test.dart`

**Verifies:** Adding, persisting, calling from, and removing favorites.

**Steps:**
1. Log in if needed.
2. Check which of contact A and B are already in favorites (to avoid duplicates).
3. Add contact A to favorites if not already there.
4. Add contact B to favorites if not already there.
5. Verify both contacts appear in the Favorites tab.
6. Log out and log back in — verify favorites persisted.
7. Open contact A's context menu (three-dots icon) — verify actions: "Audio call", "Video call", "View Contact", "Delete".
8. Tap "Audio call" for contact A — verify the call connects after 5 seconds.
9. Delete contact A from favorites via the menu.
10. Open contact B's context menu (long-press) — verify the same four actions.
11. Tap "Audio call" for contact B — verify the call connects after 5 seconds.
12. Delete contact B from favorites via long-press menu.
13. Verify the Favorites tab is empty.
14. Log out and log back in — verify deletion persisted.

---

## Incoming Call — Answer via App UI

**File:** `patrol_test/call_answer_via_app_ui_test.dart`

**Verifies:** Answering an incoming call using the in-app call screen.

**Steps:**
1. Log in if needed.
2. pjsua companion places an incoming call to the app using contact A's SIP credentials.
3. Wait for `CallActiveScaffold` to appear.
4. Tap the answer button (green phone icon) in the app UI.
5. Verify the call is active (call timer shows `00:0`).
6. Remote side hangs up.
7. Verify `CallActiveScaffold` disappears.

---

## Incoming Call — Answer via Foreground Push

**File:** `patrol_test/call_answer_via_foreground_push_test.dart`

**Verifies:** Answering an incoming call via push notification while the app is in the foreground.

**Steps:**
1. Log in if needed.
2. pjsua companion places an incoming call (app remains in the foreground).
3. Verify a push notification appears with text "You have an incoming call from …".
4. Open the notification shade and tap "Answer".
5. Verify the call is active.
6. Remote side hangs up.
7. Verify `CallActiveScaffold` disappears.

---

## Incoming Call — Answer via Background Push

**File:** `patrol_test/call_answer_via_background_push_test.dart`

**Verifies:** Answering an incoming call via push notification while the app is in the background.

**Steps:**
1. Log in if needed.
2. Press the Home button — app moves to the background.
3. pjsua companion places an incoming call.
4. Verify a push notification appears with text "You have an incoming call from …".
5. Open the notification shade and tap "Answer".
6. Verify the call is active.
7. Remote side hangs up.
8. Verify `CallActiveScaffold` disappears.

---

## Active Call Push Notification

**File:** `patrol_test/call_active_call_push_test.dart`

**Verifies:** The ongoing-call push notification is shown and can be used to hang up.

**Steps:**
1. Log in if needed.
2. pjsua companion places an incoming call.
3. Answer the call via the app UI (green phone icon).
4. Verify a persistent push notification with the text "Active call" is present.
5. Tap the "Hung up" action on the notification.
6. Verify `CallActiveScaffold` disappears.

---

## Outgoing Call — From Keypad

**File:** `patrol_test/call_outgoing_from_keypad_test.dart`

**Verifies:** Placing an outgoing call by dialling a number on the keypad.

**Steps:**
1. Log in if needed.
2. pjsua companion registers with auto-answer enabled.
3. Navigate to the Keypad tab.
4. Enter the callee number digit by digit via `KeypadKeyButton`.
5. Tap the call button.
6. Verify the call connects (`CallActiveScaffold` visible, timer running).
7. Tap the hang-up button.
8. Verify `CallActiveScaffold` disappears.

---

## Outgoing Call — Sub-functions

**File:** `patrol_test/call_outgoing_subfunctions_test.dart`

**Verifies:** In-call controls: minimize/restore, mute, speaker, hold, and video.

**Steps:**
1. Log in if needed.
2. Place an outgoing call to the external contact (pjsua auto-answers).
3. Swipe back to minimize the call — verify `CallActiveThumbnail` appears.
4. Tap the thumbnail to restore the full call screen.
5. **Mute:** tap the mute button — verify `Icons.mic_off`; tap again — verify `Icons.mic`.
6. **Speaker:** tap the speaker button — verify `Icons.volume_up`; tap again — verify `Icons.phone_in_talk`.
7. **Hold:** tap the hold button — verify "On hold" text appears; tap again — verify the timer resumes.
8. **Video:** tap the video-call button — verify the front-camera preview appears and the video renderer is active.
9. Hang up the call.

---

## Recent Calls

**File:** `patrol_test/call_recents_test.dart`

**Verifies:** Recent call entries are created and ordered correctly after each call.

**Steps:**
1. Log in if needed.
2. pjsua companion (contact A) places an incoming call → app answers → remote hangs up.
3. Navigate to the Recents tab.
4. Verify contact A appears first with an incoming call icon.
5. pjsua companion (contact B) places an incoming call → app answers → remote hangs up.
6. Verify order: contact B first (incoming), contact A second (incoming).
7. Place an outgoing call to contact A by tapping their recents tile.
8. Verify order: contact A first (outgoing, `Icons.call_made`), contact B second (incoming), contact A third (incoming).
9. Verify contact names are displayed correctly throughout.

---

## Call Transfers

**File:** `patrol_test/call_transfers_test.dart`

**Verifies:** Blind transfer and attended (consultative) transfer.

### Blind transfer

1. Log in if needed.
2. Two pjsua companions register with auto-answer (contact A and contact B).
3. Place an outgoing call to contact A — verify it connects.
4. Open the transfer menu and select "Blind transfer".
5. Enter contact B's number and confirm the transfer.
6. Verify the original call ends (`CallActiveScaffold` disappears).

### Attended transfer

1. Two new pjsua companions register with auto-answer.
2. Place an outgoing call to contact A — verify it connects.
3. Open the transfer menu and select "Attended transfer".
4. Enter contact B's number and place the consultative call.
5. Verify one call is on hold and one is active simultaneously.
6. Complete the attended transfer.
7. Verify the original call ends (`CallActiveScaffold` disappears).

---

## Smoke Test

**File:** `patrol_test/just_run_test.dart`

**Verifies:** The app launches and the root widget renders without crashing.

**Steps:**
1. Bootstrap the app.
2. Wait until `AppShell` is visible.
