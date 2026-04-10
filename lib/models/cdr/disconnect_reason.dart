enum CdrDisconnectReason {
  unknown('unknown', 'cdr_disconnectReason_unknown'),
  validCauseCodeNotYetReceived(
    'Valid cause code not yet received',
    'cdr_disconnectReason_validCauseCodeNotYetReceived',
  ),
  unallocatedNumber('Unallocated (unassigned) number', 'cdr_disconnectReason_unallocatedNumber'),
  noRouteToSpecifiedTransitNetworkWan(
    'No route to specified transit network (WAN)',
    'cdr_disconnectReason_noRouteToSpecifiedTransitNetworkWan',
  ),
  noRouteToDestination('No route to destination', 'cdr_disconnectReason_noRouteToDestination'),
  sendSpecialInformationTone('send special information tone', 'cdr_disconnectReason_sendSpecialInformationTone'),
  misdialledTrunkPrefix('misdialled trunk prefix.', 'cdr_disconnectReason_misdialledTrunkPrefix'),
  channelUnacceptable('Channel unacceptable', 'cdr_disconnectReason_channelUnacceptable'),
  callAwardedAndBeingDeliveredInAnEstablishedChannel(
    'Call awarded and being delivered in an established channel',
    'cdr_disconnectReason_callAwardedAndBeingDeliveredInAnEstablishedChannel',
  ),
  prefix0DialedButNotAllowedPreemption(
    'Prefix 0 dialed but not allowed (Preemption)',
    'cdr_disconnectReason_prefix0DialedButNotAllowedPreemption',
  ),
  prefix1DialedButNotAllowedPreemptionReserved(
    'Prefix 1 dialed but not allowed (Preemption reserved)',
    'cdr_disconnectReason_prefix1DialedButNotAllowedPreemptionReserved',
  ),
  prefix1DialedButNotRequired('Prefix 1 dialed but not required', 'cdr_disconnectReason_prefix1DialedButNotRequired'),
  moreDigitsReceivedThanAllowedCallIsProceeding(
    'More digits received than allowed, call is proceeding',
    'cdr_disconnectReason_moreDigitsReceivedThanAllowedCallIsProceeding',
  ),
  normalCallClearing('Normal call clearing', 'cdr_disconnectReason_normalCallClearing'),
  userBusy('User busy', 'cdr_disconnectReason_userBusy'),
  noUserResponding('No user responding', 'cdr_disconnectReason_noUserResponding'),
  noAnswerFromUser('no answer from user', 'cdr_disconnectReason_noAnswerFromUser'),
  subscriberIsAbsent('Subscriber is absent', 'cdr_disconnectReason_subscriberIsAbsent'),
  callRejected('Call rejected', 'cdr_disconnectReason_callRejected'),
  numberChanged('Number changed', 'cdr_disconnectReason_numberChanged'),
  reverseChargingRejected('Reverse charging rejected', 'cdr_disconnectReason_reverseChargingRejected'),
  callSuspended('Call suspended', 'cdr_disconnectReason_callSuspended'),
  callResumed('Call resumed', 'cdr_disconnectReason_callResumed'),
  nonSelectedUserClearing('Non-selected user clearing', 'cdr_disconnectReason_nonSelectedUserClearing'),
  destinationOutOfOrder('Destination out of order', 'cdr_disconnectReason_destinationOutOfOrder'),
  invalidNumberFormatIncompleteNumber(
    'Invalid number format (incomplete number)',
    'cdr_disconnectReason_invalidNumberFormatIncompleteNumber',
  ),
  facilityRejected('Facility rejected', 'cdr_disconnectReason_facilityRejected'),
  responseToStatusEnquiry('Response to STATUS ENQUIRY', 'cdr_disconnectReason_responseToStatusEnquiry'),
  normalUnspecified('Normal, unspecified', 'cdr_disconnectReason_normalUnspecified'),
  circuitOutOfOrder('Circuit out of order', 'cdr_disconnectReason_circuitOutOfOrder'),
  noCircuitChannelAvailable('No circuit/channel available', 'cdr_disconnectReason_noCircuitChannelAvailable'),
  destinationUnattainableRequireVpciVciIsNotAvailable(
    'Destination unattainable (Require VPCI VCI is not available)',
    'cdr_disconnectReason_destinationUnattainableRequireVpciVciIsNotAvailable',
  ),
  vpciVciAssignmentFailure('VPCI VCI assignment failure', 'cdr_disconnectReason_vpciVciAssignmentFailure'),
  degradedServiceCallRateIsnNotValid(
    'Degraded service (call rate isn not valid)',
    'cdr_disconnectReason_degradedServiceCallRateIsnNotValid',
  ),
  networkWanOutOfOrder('Network (WAN) out of order', 'cdr_disconnectReason_networkWanOutOfOrder'),
  transitDelayRangeCannotBeAchievedPermanentFrameModeIsOutOfService(
    'Transit delay range cannot be achieved(Permanent frame mode is out of service)',
    'cdr_disconnectReason_transitDelayRangeCannotBeAchievedPermanentFrameModeIsOutOfService',
  ),
  throughputRangeCannotBeAchievedPermanentFrameModeIsOperational(
    'Throughput range cannot be achieved (Permanent frame mode is operational)',
    'cdr_disconnectReason_throughputRangeCannotBeAchievedPermanentFrameModeIsOperational',
  ),
  temporaryFailure('Temporary failure', 'cdr_disconnectReason_temporaryFailure'),
  switchingEquipmentCongestion('Switching equipment congestion', 'cdr_disconnectReason_switchingEquipmentCongestion'),
  accessInformationDiscarded('Access information discarded', 'cdr_disconnectReason_accessInformationDiscarded'),
  requestedCircuitChannelNotAvailable(
    'Requested circuit channel not available',
    'cdr_disconnectReason_requestedCircuitChannelNotAvailable',
  ),
  preEmptedNoVpciVciIsAvailable(
    'Pre-empted (No VPCI VCI is available)',
    'cdr_disconnectReason_preEmptedNoVpciVciIsAvailable',
  ),
  precedenceCallBlocked('Precedence call blocked', 'cdr_disconnectReason_precedenceCallBlocked'),
  resourceUnavailableUnspecified(
    'Resource unavailable - unspecified',
    'cdr_disconnectReason_resourceUnavailableUnspecified',
  ),
  dspError('DSP error', 'cdr_disconnectReason_dspError'),
  qualityOfServiceUnavailable('Quality of service unavailable', 'cdr_disconnectReason_qualityOfServiceUnavailable'),
  requestedFacilityNotSubscribed(
    'Requested facility not subscribed',
    'cdr_disconnectReason_requestedFacilityNotSubscribed',
  ),
  reverseChargingNotAllowed('Reverse charging not allowed', 'cdr_disconnectReason_reverseChargingNotAllowed'),
  outgoingCallsBarred('Outgoing calls barred', 'cdr_disconnectReason_outgoingCallsBarred'),
  outgoingCallsBarredWithinCug('Outgoing calls barred within CUG', 'cdr_disconnectReason_outgoingCallsBarredWithinCug'),
  incomingCallsBarred('Incoming calls barred', 'cdr_disconnectReason_incomingCallsBarred'),
  incomingCallsBarredWithinCug('Incoming calls barred within CUG', 'cdr_disconnectReason_incomingCallsBarredWithinCug'),
  callWaitingNotSubscribed('Call waiting not subscribed', 'cdr_disconnectReason_callWaitingNotSubscribed'),
  bearerCapabilityNotAuthorized(
    'Bearer capability not authorized',
    'cdr_disconnectReason_bearerCapabilityNotAuthorized',
  ),
  bearerCapabilityNotPresentlyAvailable(
    'Bearer capability not presently available',
    'cdr_disconnectReason_bearerCapabilityNotPresentlyAvailable',
  ),
  inconsistancyInTheInformationAndClass(
    'Inconsistancy in the information and class',
    'cdr_disconnectReason_inconsistancyInTheInformationAndClass',
  ),
  serviceOrOptionNotAvailableUnspecified(
    'Service or option not available, unspecified',
    'cdr_disconnectReason_serviceOrOptionNotAvailableUnspecified',
  ),
  bearerServiceNotImplemented('Bearer service not implemented', 'cdr_disconnectReason_bearerServiceNotImplemented'),
  channelTypeNotImplemented('Channel type not implemented', 'cdr_disconnectReason_channelTypeNotImplemented'),
  transitNetworkSelectionNotImplemented(
    'Transit network selection not implemented',
    'cdr_disconnectReason_transitNetworkSelectionNotImplemented',
  ),
  messageNotImplemented('Message not implemented', 'cdr_disconnectReason_messageNotImplemented'),
  requestedFacilityNotImplemented(
    'Requested facility not implemented',
    'cdr_disconnectReason_requestedFacilityNotImplemented',
  ),
  onlyRestrictedDigitalInformationBearerCapabilityIsAvailable(
    'Only restricted digital information bearer capability is available',
    'cdr_disconnectReason_onlyRestrictedDigitalInformationBearerCapabilityIsAvailable',
  ),
  serviceOrOptionNotImplementedUnspecified(
    'Service or option not implemented, unspecified',
    'cdr_disconnectReason_serviceOrOptionNotImplementedUnspecified',
  ),
  invalidCallReferenceValue('Invalid call reference value', 'cdr_disconnectReason_invalidCallReferenceValue'),
  identifiedChannelDoesNotExist(
    'Identified channel does not exist',
    'cdr_disconnectReason_identifiedChannelDoesNotExist',
  ),
  aSuspendedCallExistsButThisCallIdentityDoesNot(
    'A suspended call exists, but this call identity does not',
    'cdr_disconnectReason_aSuspendedCallExistsButThisCallIdentityDoesNot',
  ),
  callIdentityInUse('Call identity in use', 'cdr_disconnectReason_callIdentityInUse'),
  noCallSuspended('No call suspended', 'cdr_disconnectReason_noCallSuspended'),
  callHavingTheRequestedCallIdentityHasBeenCleared(
    'Call having the requested call identity has been cleared',
    'cdr_disconnectReason_callHavingTheRequestedCallIdentityHasBeenCleared',
  ),
  calledUserNotMemberOfCug('Called user not member of CUG', 'cdr_disconnectReason_calledUserNotMemberOfCug'),
  incompatibleDestination('Incompatible destination', 'cdr_disconnectReason_incompatibleDestination'),
  nonExistentAbbreviatedAddressEntry(
    'Non-existent abbreviated address entry',
    'cdr_disconnectReason_nonExistentAbbreviatedAddressEntry',
  ),
  destinationAddressMissingAndDirectCallNotSubscribed(
    'Destination address missing, and direct call not subscribed',
    'cdr_disconnectReason_destinationAddressMissingAndDirectCallNotSubscribed',
  ),
  invalidTransitNetworkSelectionNationalUse(
    'Invalid transit network selection (national use)',
    'cdr_disconnectReason_invalidTransitNetworkSelectionNationalUse',
  ),
  invalidFacilityParameter('Invalid facility parameter', 'cdr_disconnectReason_invalidFacilityParameter'),
  mandatoryInformationElementIsMissingAalParameterIsNotSupported(
    'Mandatory information element is missing(AAL parameter is not supported)',
    'cdr_disconnectReason_mandatoryInformationElementIsMissingAalParameterIsNotSupported',
  ),
  invalidMessageUnspecified('Invalid message, unspecified', 'cdr_disconnectReason_invalidMessageUnspecified'),
  mandatoryInformationElementIsMissing(
    'Mandatory information element is missing',
    'cdr_disconnectReason_mandatoryInformationElementIsMissing',
  ),
  messageTypeNonExistentOrNotImplemented(
    'Message type non-existent or not implemented',
    'cdr_disconnectReason_messageTypeNonExistentOrNotImplemented',
  ),
  messageNotCompatibleWithCallStateOrMessageTypeNonExistentOrNotImplemented(
    'Message not compatible with call state or message type non-existent or not implemented',
    'cdr_disconnectReason_messageNotCompatibleWithCallStateOrMessageTypeNonExistentOrNotImplemented',
  ),
  informationElementNonexistantOrNotImplemented(
    'information element nonexistant or not implemented',
    'cdr_disconnectReason_informationElementNonexistantOrNotImplemented',
  ),
  invalidInformationElementContents(
    'Invalid information element contents',
    'cdr_disconnectReason_invalidInformationElementContents',
  ),
  messageNotCompatibleWithCallState(
    'Message not compatible with call state',
    'cdr_disconnectReason_messageNotCompatibleWithCallState',
  ),
  recoveryOnTimerExpiry('Recovery on timer expiry', 'cdr_disconnectReason_recoveryOnTimerExpiry'),
  parameterNonExistentOrNotImplementedPassedOn(
    'parameter non-existent or not implemented - passed on',
    'cdr_disconnectReason_parameterNonExistentOrNotImplementedPassedOn',
  ),
  urecognizedParameterMessageDiscarded(
    'Urecognized parameter message discarded',
    'cdr_disconnectReason_urecognizedParameterMessageDiscarded',
  ),
  protocolErrorUnspecified('Protocol error unspecified', 'cdr_disconnectReason_protocolErrorUnspecified'),
  internetworkingUnspecified('Internetworking, unspecified', 'cdr_disconnectReason_internetworkingUnspecified'),
  nextNodeIsUnreachable('Next node is unreachable', 'cdr_disconnectReason_nextNodeIsUnreachable'),
  holstTelephonyServiceProviderModuleHtspmIsOutOfService(
    'Holst Telephony Service Provider Module (HTSPM) is out of service',
    'cdr_disconnectReason_holstTelephonyServiceProviderModuleHtspmIsOutOfService',
  ),
  dtlTransitIsNotMyNodeId('DTL transit is not my node ID', 'cdr_disconnectReason_dtlTransitIsNotMyNodeId');

  const CdrDisconnectReason(this.rawValue, this.l10nKey);

  final String rawValue;
  final String l10nKey;
}
