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
  disconnecting,
}
