/// Sign-in tabs of the login switch screen.
///
/// [otpSignin], [passwordSignin] and [signup] are advertised by the backend
/// adapter; [qrSignin] is a client-side companion of [passwordSignin] (the
/// scanned code carries plain credentials) offered when enabled in the app
/// config and the backend supports password sign-in.
enum LoginType { otpSignin, passwordSignin, signup, qrSignin }
