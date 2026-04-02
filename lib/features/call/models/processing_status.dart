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
}
