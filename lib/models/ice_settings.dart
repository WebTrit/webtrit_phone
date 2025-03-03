import 'package:equatable/equatable.dart';

class IceSettings extends Equatable {
  const IceSettings({this.iceTransportFilter, this.iceNetworkFilter});

  final IceTransportFilter? iceTransportFilter;
  final IceNetworkFilter? iceNetworkFilter;

  factory IceSettings.blank() => const IceSettings();

  IceSettings copyWithTransportFilter(IceTransportFilter? iceTransportFilter) {
    return IceSettings(iceTransportFilter: iceTransportFilter, iceNetworkFilter: iceNetworkFilter);
  }

  IceSettings copyWithNetworkFilter(IceNetworkFilter? iceNetworkFilter) {
    return IceSettings(iceTransportFilter: iceTransportFilter, iceNetworkFilter: iceNetworkFilter);
  }

  @override
  List<Object?> get props => [iceTransportFilter, iceNetworkFilter];

  @override
  String toString() {
    return 'IceSettings(iceTransportFilter: $iceTransportFilter, iceNetworkFilter: $iceNetworkFilter)';
  }
}

enum IceTransportFilter { udp, tcp }

enum IceNetworkFilter { ipv4, ipv6 }
