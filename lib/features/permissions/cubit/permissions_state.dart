part of 'permissions_cubit.dart';

@freezed
class PermissionsState with _$PermissionsState {
  const PermissionsState({
    /// Indicates whether the initial permission request sequence has finished executing.
    ///
    /// This acts as a gatekeeper to ensure the app doesn't attempt to validate
    /// success ([isFlowCompleted]) before the user has actually attempted to grant permissions.
    this.initialRequestCompleted = false,

    /// Indicates whether the required permissions are denied in a way that prevents
    /// further in-app requests (e.g., the user selected "Don't ask again").
    ///
    /// When `true`, the system permission dialog cannot be shown. The UI should
    /// instead prompt the user to open the App Settings to enable permissions manually.
    this.isPermanentlyDenied = false,

    /// Indicates whether the permission request sequence is currently in progress.
    ///
    /// When `true`, the UI should display a loading indicator and disable interaction.
    /// This serves as a guard to prevent the user from triggering concurrent permission
    /// requests, which can lead to platform exceptions.
    this.isRequesting = false,

    /// A list of special permissions (e.g., Full Screen Intent, Overlay) that are currently denied.
    ///
    /// Unlike standard permissions, these cannot always be requested via a system modal
    /// and often require the user to manually navigate to specific settings screens.
    /// The UI uses this list to trigger dedicated instruction screens.
    this.missingSpecialPermissions = const [],

    /// Manufacturer-specific guidance for ensuring reliable background execution.
    ///
    /// Contains tips for specific vendors (e.g., enabling "AutoStart" on Xiaomi or
    /// disabling specific battery restrictions on Samsung). If non-null and not yet
    /// marked as shown, the UI should display these tips to the user.
    this.manufacturerTip,

    /// Captures any exception occurred during the permission request flow.
    ///
    /// If not null, it indicates the process failed (e.g., platform channel error),
    /// and the UI should typically display a transient error message (Snackbar).
    this.failure,
  });

  @override
  final bool initialRequestCompleted;

  @override
  final bool isPermanentlyDenied;

  @override
  final bool isRequesting;

  @override
  final List<CallkeepSpecialPermissions> missingSpecialPermissions;

  @override
  final ManufacturerTip? manufacturerTip;

  @override
  final Object? failure;

  bool get requiresSpecialPermissionsAction => missingSpecialPermissions.isNotEmpty;

  bool get shouldShowManufacturerTip => manufacturerTip != null && manufacturerTip!.shown == false;

  bool get isFlowCompleted =>
      !requiresSpecialPermissionsAction &&
      !shouldShowManufacturerTip &&
      initialRequestCompleted &&
      !isRequesting &&
      !isPermanentlyDenied;

  bool get hasFailure => failure != null;
}

@freezed
class ManufacturerTip with _$ManufacturerTip {
  const ManufacturerTip({required this.manufacturer, this.shown = false});

  @override
  final Manufacturer manufacturer;

  @override
  final bool shown;
}
