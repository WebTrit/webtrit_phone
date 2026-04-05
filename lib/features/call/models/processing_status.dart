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
  outgoingOfferPreparing,
  outgoingOfferSent,
  outgoingRinging,

  connected,
  disconnecting,
}
