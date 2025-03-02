import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/audio_processing_settings.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';
import 'package:webtrit_phone/models/ice_settings.dart';
import 'package:webtrit_phone/models/rtp_codec_profile.dart';
import 'package:webtrit_phone/models/video_capturing_settings.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'components/choosable_section.dart';
import 'components/heading_section.dart';
import 'components/inline_choosable_section.dart';
import 'components/reorderable_section.dart';
import 'components/slidable_section.dart';
import '../media_settings.dart';

class MediaSettingsScreen extends StatefulWidget {
  const MediaSettingsScreen({super.key});

  @override
  State<MediaSettingsScreen> createState() => _MediaSettingsScreenState();
}

class _MediaSettingsScreenState extends State<MediaSettingsScreen> {
  late final cubit = context.read<MediaSettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_mediaSettings),
        leading: const ExtBackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_backup_restore),
            tooltip: context.l10n.settings_encoding_AppBar_reset_tooltip,
            onPressed: () => cubit.reset(),
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
      body: BlocBuilder<MediaSettingsCubit, MediaSettingsState>(
        builder: (context, state) {
          final encodingPreset = state.encodingPreset;
          final encodingSettings = state.encodingSettings;
          final audioProcessingSettings = state.audioProcessingSettings;
          final videoCapturingSettings = state.videoCapturingSettings;
          final iceSettings = state.iceSettings;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                encodingPresetContent(context, encodingPreset),
                if (encodingPreset == EncodingPreset.custom) ...[
                  const SizedBox(height: 24),
                  encodingCustomContent(context, encodingSettings)
                ],
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
                audioProcessingContent(context, audioProcessingSettings),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
                videoCapturingContent(context, videoCapturingSettings),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
                iceSettingsContent(context, iceSettings),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget encodingPresetContent(BuildContext context, EncodingPreset? encodingPreset) {
    return Column(
      children: [
        HeadingSection(
          title: context.l10n.settings_encoding_Section_preset_title,
          tooltip: context.l10n.settings_encoding_Section_preset_tooltip,
          icon: const Icon(Icons.segment_outlined),
        ),
        const SizedBox(height: 16.0),
        ChoosableSection<EncodingPreset>(
          title: null,
          buildOptionTitle: (option) {
            return Text(switch (option) {
              null => context.l10n.settings_encoding_Section_preset_default,
              EncodingPreset.eco => context.l10n.settings_encoding_Section_preset_eco,
              EncodingPreset.balance => context.l10n.settings_encoding_Section_preset_balance,
              EncodingPreset.quality => context.l10n.settings_encoding_Section_preset_quality,
              EncodingPreset.fullFlex => context.l10n.settings_encoding_Section_preset_full_flex,
              EncodingPreset.custom => context.l10n.settings_encoding_Section_preset_custom,
            });
          },
          options: EncodingPreset.values,
          selected: encodingPreset,
          onSelect: (option) => cubit.setEncodingPreset(option),
        ),
      ],
    );
  }

  Widget encodingCustomContent(BuildContext context, EncodingSettings encodingSettings) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeadingSection(
          title: context.l10n.settings_encoding_Section_bitrate_title,
          tooltip: context.l10n.settings_encoding_Section_bitrate_tooltip,
          icon: const Icon(Icons.one_k_plus_sharp),
        ),
        const SizedBox(height: 16.0),
        SlidableSection<int>(
          title: context.l10n.settings_encoding_Section_target_audio_bitrate,
          optionPrefix: context.l10n.settings_encoding_Section_bitrate_prefix,
          buildOptionLabel: (option) {
            if (option == null) return context.l10n.settings_encoding_Section_value_auto;
            return '$option ${context.l10n.settings_encoding_Section_measure_kbps}';
          },
          options: EncodingSettings.audioBitrateOptions,
          selected: encodingSettings.audioBitrate,
          onSelect: (option) => cubit.setEncodingSettings(encodingSettings.copyWithAudioBitrate(option)),
        ),
        const SizedBox(height: 16.0),
        SlidableSection<int>(
          title: context.l10n.settings_encoding_Section_target_video_bitrate,
          optionPrefix: context.l10n.settings_encoding_Section_bitrate_prefix,
          buildOptionLabel: (option) {
            if (option == null) return context.l10n.settings_encoding_Section_value_auto;
            return '$option ${context.l10n.settings_encoding_Section_measure_kbps}';
          },
          options: EncodingSettings.videoBitrateOptions,
          selected: encodingSettings.videoBitrate,
          onSelect: (option) => cubit.setEncodingSettings(encodingSettings.copyWithVideoBitrate(option)),
        ),
        const SizedBox(height: 24),
        HeadingSection(
          title: context.l10n.settings_encoding_Section_packetization_title,
          tooltip: context.l10n.settings_encoding_Section_packetization_tooltip,
          icon: const Icon(Icons.vertical_split_rounded),
        ),
        const SizedBox(height: 16.0),
        SlidableSection<int>(
          title: context.l10n.settings_encoding_Section_audio_ptime,
          optionPrefix: context.l10n.settings_encoding_Section_ptime_prefix,
          buildOptionLabel: (option) {
            if (option == null) return context.l10n.settings_encoding_Section_value_auto;
            return '$option ${context.l10n.settings_encoding_Section_measure_ms}';
          },
          options: EncodingSettings.ptimeOptions,
          selected: encodingSettings.ptime,
          onSelect: (option) {
            var newSettings = encodingSettings.copyWithPtime(option);
            cubit.setEncodingSettings(newSettings);
            if (option != null && encodingSettings.maxptime != null && option > encodingSettings.maxptime!) {
              newSettings = newSettings.copyWithMaxptime(option);
              cubit.setEncodingSettings(newSettings);
            }
          },
        ),
        const SizedBox(height: 16.0),
        SlidableSection<int>(
          title: context.l10n.settings_encoding_Section_audio_ptime_limit,
          optionPrefix: context.l10n.settings_encoding_Section_ptime_prefix,
          buildOptionLabel: (option) {
            if (option == null) return context.l10n.settings_encoding_Section_value_auto;
            return '$option ${context.l10n.settings_encoding_Section_measure_ms}';
          },
          options: EncodingSettings.ptimeOptions,
          selected: encodingSettings.maxptime,
          onSelect: (option) {
            var newSettings = encodingSettings.copyWithMaxptime(option);
            cubit.setEncodingSettings(newSettings);
            if (option != null && encodingSettings.ptime != null && option < encodingSettings.ptime!) {
              newSettings = newSettings.copyWithPtime(option);
              cubit.setEncodingSettings(newSettings);
            }
          },
        ),
        const SizedBox(height: 24),
        HeadingSection(
          title: context.l10n.settings_encoding_Section_opus_title,
          tooltip: context.l10n.settings_encoding_Section_opus_tooltip,
          icon: const Icon(Icons.settings),
        ),
        const SizedBox(height: 16.0),
        SlidableSection<int>(
          title: context.l10n.settings_encoding_Section_opus_bandwidth,
          optionPrefix: context.l10n.settings_encoding_Section_bandwidth_prefix,
          buildOptionLabel: (option) {
            if (option == null) return context.l10n.settings_encoding_Section_value_auto;
            return '$option ${context.l10n.settings_encoding_Section_measure_hz}';
          },
          options: EncodingSettings.opusBandwidthLimitOptions,
          selected: encodingSettings.opusBandwidthLimit,
          onSelect: (option) => cubit.setEncodingSettings(encodingSettings.copyWithOpusBandwidthLimit(option)),
        ),
        const SizedBox(height: 16.0),
        InlineChoosableSection<bool>(
          title: context.l10n.settings_encoding_Section_opus_channels,
          buildOptionTitle: (option) {
            if (option == true) return Text(context.l10n.settings_encoding_Section_value_stereo);
            if (option == false) return Text(context.l10n.settings_encoding_Section_value_mono);

            return Text(context.l10n.settings_encoding_Section_value_auto);
          },
          options: const [true, false],
          selected: encodingSettings.opusStereo,
          onSelect: (option) => cubit.setEncodingSettings(encodingSettings.copyWithOpusStereo(option)),
        ),
        const SizedBox(height: 16.0),
        InlineChoosableSection<bool>(
          title: context.l10n.settings_encoding_Section_opus_dtx,
          buildOptionTitle: (option) {
            if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
            if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

            return Text(context.l10n.settings_encoding_Section_value_auto);
          },
          options: const [true, false],
          selected: encodingSettings.opusDtx,
          onSelect: (option) => cubit.setEncodingSettings(encodingSettings.copyWithOpusDtx(option)),
        ),
        const SizedBox(height: 24),
        HeadingSection(
          title: context.l10n.settings_encoding_Section_rtp_override_title,
          tooltip: context.l10n.settings_encoding_Section_rtp_override_tooltip,
          icon: const Icon(Icons.sip),
        ),
        const SizedBox(height: 16.0),
        ReorderableSection<RTPCodecProfile>(
          title: context.l10n.settings_encoding_Section_rtp_override_audio,
          warningTitle: context.l10n.settings_encoding_Section_rtp_override_warning_title,
          warningMessage: context.l10n.settings_encoding_Section_rtp_override_warning_message,
          buildOptionTitle: (option) {
            if (option == null) return Text(context.l10n.settings_encoding_Section_value_auto);
            return Text(option.name);
          },
          enabled: encodingSettings.audioProfiles != null,
          onEnable: (enabled) {
            if (enabled) {
              var profiles = EncodingSettings.defaultAudioProfilesOrder;
              cubit.setEncodingSettings(encodingSettings.copyWithAudioProfiles(profiles));
            } else {
              cubit.setEncodingSettings(encodingSettings.copyWithAudioProfiles(null));
            }
          },
          items: encodingSettings.audioProfiles ?? [],
          onChange: (items) => cubit.setEncodingSettings(encodingSettings.copyWithAudioProfiles(items)),
        ),
        const SizedBox(height: 16.0),
        ReorderableSection<RTPCodecProfile>(
          title: context.l10n.settings_encoding_Section_rtp_override_video,
          warningTitle: context.l10n.settings_encoding_Section_rtp_override_warning_title,
          warningMessage: context.l10n.settings_encoding_Section_rtp_override_warning_message,
          buildOptionTitle: (option) {
            if (option == null) return Text(context.l10n.settings_encoding_Section_value_auto);
            return Text(option.name);
          },
          enabled: encodingSettings.videoProfiles != null,
          onEnable: (enabled) {
            if (enabled) {
              var profiles = EncodingSettings.defaultVideoProfilesOrder;
              cubit.setEncodingSettings(encodingSettings.copyWithVideoProfiles(profiles));
            } else {
              cubit.setEncodingSettings(encodingSettings.copyWithVideoProfiles(null));
            }
          },
          items: encodingSettings.videoProfiles ?? [],
          onChange: (items) => cubit.setEncodingSettings(encodingSettings.copyWithVideoProfiles(items)),
        ),
        // const SizedBox(height: 16.0),
      ],
    );
  }

  Widget audioProcessingContent(BuildContext context, AudioProcessingSettings audioProcessingSettings) {
    return Column(
      children: [
        HeadingSection(
          title: context.l10n.settings_audioProcessing_Section_title,
          tooltip: context.l10n.settings_audioProcessing_Section_tooltip,
          icon: const Icon(Icons.multitrack_audio),
        ),
        const SizedBox(height: 16.0),
        InlineChoosableSection<bool>(
          title: context.l10n.settings_audioProcessing_Section_VP_title,
          buildOptionTitle: (option) {
            if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
            if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

            return Text(context.l10n.settings_encoding_Section_value_auto);
          },
          options: const [true, false],
          selected: audioProcessingSettings.bypassVoiceProcessing,
          onSelect: (option) =>
              cubit.setAudioProcessingSettings(audioProcessingSettings.copyWithBypassVoiceProcessing(option)),
        ),
        const SizedBox(height: 16.0),
        InlineChoosableSection<bool>(
          title: context.l10n.settings_audioProcessing_Section_EC_title,
          buildOptionTitle: (option) {
            if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
            if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

            return Text(context.l10n.settings_encoding_Section_value_auto);
          },
          options: const [true, false],
          selected: audioProcessingSettings.echoCancellation,
          onSelect: (option) =>
              cubit.setAudioProcessingSettings(audioProcessingSettings.copyWithEchoCancellation(option)),
        ),
        const SizedBox(height: 16.0),
        InlineChoosableSection<bool>(
          title: context.l10n.settings_audioProcessing_Section_AGC_title,
          buildOptionTitle: (option) {
            if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
            if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

            return Text(context.l10n.settings_encoding_Section_value_auto);
          },
          options: const [true, false],
          selected: audioProcessingSettings.autoGainControl,
          onSelect: (option) =>
              cubit.setAudioProcessingSettings(audioProcessingSettings.copyWithAutoGainControl(option)),
        ),
        const SizedBox(height: 16.0),
        InlineChoosableSection<bool>(
          title: context.l10n.settings_audioProcessing_Section_NS_title,
          buildOptionTitle: (option) {
            if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
            if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

            return Text(context.l10n.settings_encoding_Section_value_auto);
          },
          options: const [true, false],
          selected: audioProcessingSettings.noiseSuppression,
          onSelect: (option) =>
              cubit.setAudioProcessingSettings(audioProcessingSettings.copyWithNoiseSuppression(option)),
        ),
        const SizedBox(height: 16.0),
        InlineChoosableSection<bool>(
          title: context.l10n.settings_audioProcessing_Section_HPF_title,
          buildOptionTitle: (option) {
            if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
            if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

            return Text(context.l10n.settings_encoding_Section_value_auto);
          },
          options: const [true, false],
          selected: audioProcessingSettings.highpassFilter,
          onSelect: (option) =>
              cubit.setAudioProcessingSettings(audioProcessingSettings.copyWithHighpassFilter(option)),
        ),
        const SizedBox(height: 16.0),
        InlineChoosableSection<bool>(
          title: context.l10n.settings_audioProcessing_Section_AM_title,
          buildOptionTitle: (option) {
            if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
            if (option == false) return Text(context.l10n.settings_encoding_Section_value_off);

            return Text(context.l10n.settings_encoding_Section_value_auto);
          },
          options: const [true, false],
          selected: audioProcessingSettings.audioMirroring,
          onSelect: (option) =>
              cubit.setAudioProcessingSettings(audioProcessingSettings.copyWithAudioMirroring(option)),
        ),
      ],
    );
  }

  Column videoCapturingContent(BuildContext context, VideoCapturingSettings videoCapturingSettings) {
    return Column(
      children: [
        HeadingSection(
          title: context.l10n.settings_videoCapturing_Section_title,
          tooltip: context.l10n.settings_videoCapturing_Section_tooltip,
          icon: const Icon(Icons.video_settings_rounded),
        ),
        const SizedBox(height: 16.0),
        SlidableSection<Resolution>(
          title: context.l10n.settings_videoCapturing_Section_resolution_title,
          optionPrefix: context.l10n.settings_videoCapturing_Section_resolution_prefix,
          buildOptionLabel: (option) {
            if (option == null) return context.l10n.settings_encoding_Section_value_auto;
            return option.str;
          },
          options: Resolution.values,
          selected: videoCapturingSettings.resolution,
          onSelect: (option) => cubit.setVideoCapturingSettings(videoCapturingSettings.copyWithResolution(option)),
        ),
        const SizedBox(height: 16.0),
        SlidableSection<Framerate>(
          title: context.l10n.settings_videoCapturing_Section_framerate_title,
          optionPrefix: context.l10n.settings_videoCapturing_Section_framerate_prefix,
          buildOptionLabel: (option) {
            if (option == null) return context.l10n.settings_encoding_Section_value_auto;
            return option.str;
          },
          options: Framerate.values,
          selected: videoCapturingSettings.framerate,
          onSelect: (option) => cubit.setVideoCapturingSettings(videoCapturingSettings.copyWithFramerate(option)),
        ),
      ],
    );
  }

  Widget iceSettingsContent(BuildContext context, IceSettings iceSettings) {
    return Column(
      children: [
        HeadingSection(
          title: context.l10n.settings_iceSettings_Section_title,
          tooltip: context.l10n.settings_iceSettings_Section_tooltip,
          icon: const Icon(Icons.bubble_chart),
        ),
        const SizedBox(height: 16.0),
        ChoosableSection<IceNetworkFilter>(
          title: context.l10n.settings_iceSettings_Section_netfilter_title,
          buildOptionTitle: (option) {
            if (option == IceNetworkFilter.ipv4) {
              return Text(context.l10n.settings_iceSettings_Section_netfilter_skipv4);
            }
            if (option == IceNetworkFilter.ipv6) {
              return Text(context.l10n.settings_iceSettings_Section_netfilter_skipv6);
            }

            return Text(context.l10n.settings_iceSettings_Section_noskip);
          },
          options: const [IceNetworkFilter.ipv4, IceNetworkFilter.ipv6],
          selected: iceSettings.iceNetworkFilter,
          onSelect: (option) => cubit.setIceSettings(iceSettings.copyWithNetworkFilter(option)),
        ),
        const SizedBox(height: 16.0),
        ChoosableSection<IceTransportFilter>(
          title: context.l10n.settings_iceSettings_Section_trfilter_title,
          buildOptionTitle: (option) {
            if (option == IceTransportFilter.tcp) {
              return Text(context.l10n.settings_iceSettings_Section_trfilter_skipTcp);
            }
            if (option == IceTransportFilter.udp) {
              return Text(context.l10n.settings_iceSettings_Section_trfilter_skipUdp);
            }

            return Text(context.l10n.settings_iceSettings_Section_noskip);
          },
          options: const [IceTransportFilter.tcp, IceTransportFilter.udp],
          selected: iceSettings.iceTransportFilter,
          onSelect: (option) => cubit.setIceSettings(iceSettings.copyWithTransportFilter(option)),
        ),
      ],
    );
  }
}
