import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/settings/features/media_settings/media_settings.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';
import 'package:webtrit_phone/models/rtp_codec_profile.dart';

class EncodingCustomContent extends StatelessWidget {
  const EncodingCustomContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MediaSettingsCubit>();

    return BlocBuilder<MediaSettingsCubit, MediaSettingsState>(
      buildWhen: (p, c) => p.encodingSettings != c.encodingSettings,
      builder: (context, state) {
        final encodingSettings = state.encodingSettings;

        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            HeadingSection(
              title: context.l10n.settings_encoding_Section_bitrate_title,
              tooltip: context.l10n.settings_encoding_Section_bitrate_tooltip,
              icon: const Icon(Icons.one_k_plus_sharp),
            ),
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
            const Divider(height: 24),
            HeadingSection(
              title: context.l10n.settings_encoding_Section_packetization_title,
              tooltip: context.l10n.settings_encoding_Section_packetization_tooltip,
              icon: const Icon(Icons.vertical_split_rounded),
            ),
            Column(
              children: [
                Text(
                  context.l10n.settings_encoding_Section_packetization_warning_title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  context.l10n.settings_encoding_Section_packetization_warning_message,
                  style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12.0),
                ),
              ],
            ),
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

            const Divider(height: 24),
            HeadingSection(
              title: context.l10n.settings_encoding_Section_opus_title,
              tooltip: context.l10n.settings_encoding_Section_opus_tooltip,
              icon: const Icon(Icons.settings),
            ),
            SlidableSection<int>(
              title: context.l10n.settings_encoding_Section_opus_samplingRate,
              optionPrefix: context.l10n.settings_encoding_Section_bandwidth_prefix,
              buildOptionLabel: (option) {
                if (option == null) return context.l10n.settings_encoding_Section_value_auto;
                return '$option ${context.l10n.settings_encoding_Section_measure_hz}';
              },
              options: EncodingSettings.opusSamplingRateOptions,
              selected: encodingSettings.opusSamplingRate,
              onSelect: (option) => cubit.setEncodingSettings(encodingSettings.copyWithOpusSamplingRate(option)),
            ),
            SlidableSection<int>(
              title: context.l10n.settings_encoding_Section_opus_bitrate,
              optionPrefix: context.l10n.settings_encoding_Section_bitrate_prefix,
              buildOptionLabel: (option) {
                if (option == null) return context.l10n.settings_encoding_Section_value_auto;
                return '$option ${context.l10n.settings_encoding_Section_measure_kbps}';
              },
              options: EncodingSettings.opusBitrateOptions,
              selected: encodingSettings.opusBitrate,
              onSelect: (option) => cubit.setEncodingSettings(encodingSettings.copyWithOpusBitrate(option)),
            ),
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
            const Divider(height: 24),
            HeadingSection(
              title: context.l10n.settings_encoding_Section_rtp_override_title,
              tooltip: context.l10n.settings_encoding_Section_rtp_override_tooltip,
              icon: const Icon(Icons.sip),
            ),
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
            const Divider(height: 24),
            HeadingSection(
              title: context.l10n.settings_encoding_Section_rtp_extensions_title,
              icon: const Icon(Icons.extension_off),
              tooltip: context.l10n.settings_encoding_Section_rtp_extensions_tooltip,
            ),
            _ExtmapToggle(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeExtmap_twcc,
              type: SdpExtmapType.twcc,
              encodingSettings: encodingSettings,
              cubit: cubit,
            ),
            _ExtmapToggle(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeExtmap_absSendTime,
              type: SdpExtmapType.absSendTime,
              encodingSettings: encodingSettings,
              cubit: cubit,
            ),
            _ExtmapToggle(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeExtmap_playoutDelay,
              type: SdpExtmapType.playoutDelay,
              encodingSettings: encodingSettings,
              cubit: cubit,
            ),
            _ExtmapToggle(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeExtmap_videoContentType,
              type: SdpExtmapType.videoContentType,
              encodingSettings: encodingSettings,
              cubit: cubit,
            ),
            _ExtmapToggle(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeExtmap_videoTiming,
              type: SdpExtmapType.videoTiming,
              encodingSettings: encodingSettings,
              cubit: cubit,
            ),
            _ExtmapToggle(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeExtmap_colorSpace,
              type: SdpExtmapType.colorSpace,
              encodingSettings: encodingSettings,
              cubit: cubit,
            ),
            _ExtmapToggle(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeExtmap_audioLevel,
              type: SdpExtmapType.audioLevel,
              encodingSettings: encodingSettings,
              cubit: cubit,
            ),
            _ExtmapToggle(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeExtmap_tOffset,
              type: SdpExtmapType.tOffset,
              encodingSettings: encodingSettings,
              cubit: cubit,
            ),
            _ExtmapToggle(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeExtmap_videoOrientation,
              type: SdpExtmapType.videoOrientation,
              encodingSettings: encodingSettings,
              cubit: cubit,
            ),
            _ExtmapToggle(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeExtmap_rtpStreamId,
              type: SdpExtmapType.rtpStreamId,
              encodingSettings: encodingSettings,
              cubit: cubit,
            ),
            _ExtmapToggle(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeExtmap_repairedRtpStreamId,
              type: SdpExtmapType.repairedRtpStreamId,
              encodingSettings: encodingSettings,
              cubit: cubit,
            ),
            const Divider(height: 24),
            HeadingSection(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_title,
              icon: const Icon(Icons.edit_note_sharp),
            ),
            InlineSelectableSection<bool>(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeStaticRtpmaps,
              tooltip: context.l10n.settings_encoding_Section_extra_sdp_mod_removeStaticRtpmaps_tooltip,
              buildOptionTitle: (option) {
                if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
                return Text(context.l10n.settings_encoding_Section_value_off);
              },
              selected: encodingSettings.removeStaticAudioRtpMaps,
              onSelect: (option) =>
                  cubit.setEncodingSettings(encodingSettings.copyWithRemoveStaticAudioRtpMaps(option)),
            ),
            InlineSelectableSection<bool>(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_remapTE8,
              tooltip: context.l10n.settings_encoding_Section_extra_sdp_mod_remapTE8_tooltip,
              buildOptionTitle: (option) {
                if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
                return Text(context.l10n.settings_encoding_Section_value_off);
              },
              selected: encodingSettings.remapTE8payloadTo101,
              onSelect: (option) => cubit.setEncodingSettings(encodingSettings.copyWithRemapTE8payloadTo101(option)),
            ),
            InlineSelectableSection<bool>(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeREMBFeedback,
              tooltip: context.l10n.settings_encoding_Section_extra_sdp_mod_removeREMBFeedback_tooltip,
              buildOptionTitle: (option) {
                if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
                return Text(context.l10n.settings_encoding_Section_value_off);
              },
              selected: encodingSettings.removeREMBFeedback,
              onSelect: (option) => cubit.setEncodingSettings(encodingSettings.copyWithRemoveREMBFeedback(option)),
            ),
            InlineSelectableSection<bool>(
              title: context.l10n.settings_encoding_Section_extra_sdp_mod_removeTWCCFeedback,
              tooltip: context.l10n.settings_encoding_Section_extra_sdp_mod_removeTWCCFeedback_tooltip,
              buildOptionTitle: (option) {
                if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
                return Text(context.l10n.settings_encoding_Section_value_off);
              },
              selected: encodingSettings.removeTWCCFeedback,
              onSelect: (option) => cubit.setEncodingSettings(encodingSettings.copyWithRemoveTWCCFeedback(option)),
            ),
          ],
        );
      },
    );
  }
}

class _ExtmapToggle extends StatelessWidget {
  const _ExtmapToggle({required this.title, required this.type, required this.encodingSettings, required this.cubit});

  final String title;
  final SdpExtmapType type;
  final EncodingSettings encodingSettings;
  final MediaSettingsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return InlineSelectableSection<bool>(
      title: title,
      buildOptionTitle: (option) {
        if (option == true) return Text(context.l10n.settings_encoding_Section_value_on);
        return Text(context.l10n.settings_encoding_Section_value_off);
      },
      selected: encodingSettings.removeExtmaps.contains(type),
      onSelect: (v) => cubit.setEncodingSettings(
        encodingSettings.copyWithRemoveExtmaps(
          v
              ? [...encodingSettings.removeExtmaps, type]
              : encodingSettings.removeExtmaps.where((e) => e != type).toList(),
        ),
      ),
    );
  }
}
