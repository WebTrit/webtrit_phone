import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

/// Height of the row of categories, and of every tab in it: a target smaller
/// than this cannot be hit reliably.
const double _categoryTabSize = kMinInteractiveDimension;

/// Height of the picker itself; the sheet takes no more than this.
const double _pickerHeight = 300;

/// The modal bottom sheet that picks the icon shown next to the presence
/// status.
///
/// Closes with the chosen emoji, or with nothing when it is dismissed.
class StatusIconPickerDialog extends StatelessWidget {
  const StatusIconPickerDialog({super.key});

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.hardEdge,
      builder: (context) => const StatusIconPickerDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // The picker package defaults every surface to its own light palette, so
    // without this the sheet stays white inside a dark theme.
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    // The theme draws the tab indicator as a filled pill, so the selected
    // icon has to use the color the theme pairs with it - the same primary as
    // the pill would dissolve the icon completely.
    final selectedTabColor = theme.tabBarTheme.labelColor ?? colorScheme.onPrimary;

    return Padding(
      // Keeps the sheet above the keyboard while the icon search is typing.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SizedBox(
        width: double.infinity,
        height: _pickerHeight,
        child: EmojiPicker(
          config: Config(
            emojiViewConfig: EmojiViewConfig(backgroundColor: colorScheme.surface, emojiSizeMax: 20),
            categoryViewConfig: CategoryViewConfig(
              tabBarHeight: _categoryTabSize,
              backgroundColor: colorScheme.surface,
              iconColor: colorScheme.onSurfaceVariant,
              iconColorSelected: selectedTabColor,
              indicatorColor: colorScheme.primary,
              dividerColor: colorScheme.outlineVariant,
              customCategoryView: (config, state, tabController, pageController) =>
                  StatusIconCategoryView(config, state, tabController, pageController),
            ),
            searchViewConfig: SearchViewConfig(
              backgroundColor: colorScheme.surface,
              buttonIconColor: colorScheme.onSurfaceVariant,
              inputTextStyle: TextStyle(color: colorScheme.onSurface),
              hintTextStyle: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            skinToneConfig: SkinToneConfig(
              dialogBackgroundColor: colorScheme.surfaceContainerHigh,
              indicatorColor: colorScheme.onSurfaceVariant,
            ),
            // The bar along the bottom of the picker offers a backspace
            // button wired to a text field this sheet does not have, so
            // pressing it does nothing; the way to search is offered next to
            // the categories instead.
            bottomActionBarConfig: const BottomActionBarConfig(enabled: false),
          ),
          onEmojiSelected: (category, emoji) => Navigator.pop(context, emoji.emoji),
        ),
      ),
    );
  }
}

/// Row of emoji categories of the picker, with the search button beside them.
///
/// The picker's own row squeezes all nine categories into the width of the
/// sheet, which leaves each of them little more than half the size a target
/// has to be. This row scrolls instead, so every category keeps a full-size
/// target of its own.
class StatusIconCategoryView extends CategoryView {
  const StatusIconCategoryView(super.config, super.state, super.tabController, super.pageController, {super.key});

  @override
  CategoryViewState<StatusIconCategoryView> createState() => _StatusIconCategoryViewState();
}

class _StatusIconCategoryViewState extends CategoryViewState<StatusIconCategoryView> {
  @override
  Widget build(BuildContext context) {
    final categoryViewConfig = widget.config.categoryViewConfig;
    return Container(
      color: categoryViewConfig.backgroundColor,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: _categoryTabSize,
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                controller: widget.tabController,
                labelColor: categoryViewConfig.iconColorSelected,
                unselectedLabelColor: categoryViewConfig.iconColor,
                indicatorColor: categoryViewConfig.indicatorColor,
                dividerColor: categoryViewConfig.dividerColor,
                onTap: (index) {
                  closeSkinToneOverlay();
                  widget.pageController.jumpToPage(index);
                },
                tabs: [
                  for (final categoryEmoji in widget.state.categoryEmoji)
                    Tab(
                      height: _categoryTabSize,
                      icon: Icon(getIconForCategory(categoryViewConfig.categoryIcons, categoryEmoji.category)),
                    ),
                ],
              ),
            ),
          ),
          SearchButton(widget.config, widget.state.onShowSearchView, categoryViewConfig.iconColor),
        ],
      ),
    );
  }
}
