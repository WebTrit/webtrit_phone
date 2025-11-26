enum CallProcessingStatus {
  incomingFromPush,
  incomingFromOffer,
  incomingSubmittedAnswer,
  incomingPerformingStarted,
  incomingInitializingMedia,
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

  deniedMicrophone,
}
