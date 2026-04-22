enum CallProcessingStatus {
  incomingFromPush,
  incomingFromOffer,
  incomingSubmittedAnswer,
  incomingPerformingStarted,
  incomingInitializingMedia,
  incomingRestoringMedia,
  incomingAnswering,

  outgoingCreated,
  outgoingCreatedFromRefer,
  outgoingConnectingToSignaling,
  outgoingInitializingMedia,
  outgoingRestoringMedia,
  outgoingOfferPreparing,
  outgoingOfferSent,
  outgoingRinging,

  connected,
  disconnecting;

  bool get isPreOfferSent => const {
    CallProcessingStatus.outgoingCreated,
    CallProcessingStatus.outgoingCreatedFromRefer,
    CallProcessingStatus.outgoingConnectingToSignaling,
    CallProcessingStatus.outgoingInitializingMedia,
    CallProcessingStatus.outgoingOfferPreparing,
  }.contains(this);

  bool get hasPeerConnectionReady => const {
    CallProcessingStatus.outgoingOfferSent,
    CallProcessingStatus.outgoingRinging,
    CallProcessingStatus.connected,
  }.contains(this);
}
