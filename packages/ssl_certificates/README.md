
## ssl_certificates

Document describes the functionality for initializing a SecurityContext object with trusted certificates in Dart.

### Function: initialize security context

The `initializeSecurityContext` function takes a `TrustedCertificates` object as input and returns a `SecurityContext` object.

-   If the `TrustedCertificates` object does not have any available certificates, the function returns `null`.
-   Otherwise, it creates a new `SecurityContext` object with the `withTrustedRoots` flag set to `true`.
-   It then iterates through each certificate in the `TrustedCertificates` object and adds them to the `SecurityContext` using the `setTrustedCertificatesBytes` method.
-   The password for the certificate is provided if available.

### Class: TrustedCertificates

The `TrustedCertificates` class represents a collection of trusted certificates.

-   The `_internal` constructor is private and used internally to create a `TrustedCertificates` object.
-   The `empty` factory constructor creates an empty `TrustedCertificates` object with no certificates.
-   The main factory constructor creates a `TrustedCertificates` object from a list of `BridgeX509Certificate` objects. It throws an `ArgumentError` if the provided list is empty.
-   The `certificates` property holds the list of trusted certificates.
-   The `hasAvailableCertificates` property returns `true` if there are any certificates in the list, otherwise `false`.

### Class: BridgeX509Certificate

The `BridgeX509Certificate` class represents a single trusted certificate.

-   The `certBytes` property holds the raw bytes of the certificate.
-   The `password` property holds the password for the certificate (optional).

This functionality provides a way to securely configure a `SecurityContext` object with trusted certificates for use in network communication within your Dart application.
