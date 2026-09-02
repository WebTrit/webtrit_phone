import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// Height of the row of categories, and of every tab in it: a target smaller
/// than this cannot be hit reliably.
const double _categoryTabSize = kMinInteractiveDimension;

/// Height of the picker itself; the sheet takes no more than this.
const double _pickerHeight = 300;

/// The modal bottom sheet that picks the icon shown next to the presence
/// status.
///
/// Closes with the chosen emoji, or with nothing when it is dismissed.
class StatusIconPickerSheet extends StatelessWidget {
  const StatusIconPickerSheet({super.key});

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.hardEdge,
      builder: (context) => const StatusIconPickerSheet(),
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
      child: SemanticId(
        identifier: statusIconPickerId,
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
                customSearchView: (config, state, showEmojiView) => StatusIconSearchView(config, state, showEmojiView),
              ),
              skinToneConfig: SkinToneConfig(
                dialogBackgroundColor: colorScheme.surfaceContainerHigh,
                indicatorColor: colorScheme.onSurfaceVariant,
              ),
              // The bar along the bottom of the picker offers a backspace
              // button wired to a text field this sheet does not have, so
              // pressing it does nothing; the way to search is offered next
              // to the categories instead.
              bottomActionBarConfig: const BottomActionBarConfig(enabled: false),
            ),
            onEmojiSelected: (category, emoji) => Navigator.pop(context, emoji.emoji),
          ),
        ),
      ),
    );
  }
}

/// Row of emoji categories of the picker, with the search button beside them.
///
/// The picker's own row squeezes all nine categories into the width of the
/// sheet, which leaves each of them little more than half the size a target
/// has to be, and offers them as nine tabs with no name but their number.
/// This row scrolls instead, so every category keeps a full-size target of its
/// own, and each one says which category it is.
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
                      // The tab bar merges each tab into a single node with the
                      // press on it, so the name and the id given here are what
                      // that node carries.
                      icon: Semantics(
                        label: categoryName(context, categoryEmoji.category),
                        identifier: categoryTabId(categoryEmoji.category),
                        child: Icon(getIconForCategory(categoryViewConfig.categoryIcons, categoryEmoji.category)),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SemanticAction(
            label: context.l10n.presenceSettings_SemanticsLabel_searchIcons,
            identifier: statusIconPickerSearchId,
            child: SearchButton(widget.config, widget.state.onShowSearchView, categoryViewConfig.iconColor),
          ),
        ],
      ),
    );
  }
}

/// Automation id of a category tab, built from the category it stands for
/// rather than from its position in the row.
String categoryTabId(Category category) =>
    settingsOptionId(statusIconPickerCategoryIdPrefix, category.name.toLowerCase());

/// Spoken name of an emoji category; the tabs show nothing but an icon.
String categoryName(BuildContext context, Category category) {
  final l10n = context.l10n;
  return switch (category) {
    Category.RECENT => l10n.presenceSettings_SemanticsLabel_iconCategoryRecent,
    Category.SMILEYS => l10n.presenceSettings_SemanticsLabel_iconCategorySmileys,
    Category.ANIMALS => l10n.presenceSettings_SemanticsLabel_iconCategoryAnimals,
    Category.FOODS => l10n.presenceSettings_SemanticsLabel_iconCategoryFoods,
    Category.ACTIVITIES => l10n.presenceSettings_SemanticsLabel_iconCategoryActivities,
    Category.TRAVEL => l10n.presenceSettings_SemanticsLabel_iconCategoryTravel,
    Category.OBJECTS => l10n.presenceSettings_SemanticsLabel_iconCategoryObjects,
    Category.SYMBOLS => l10n.presenceSettings_SemanticsLabel_iconCategorySymbols,
    Category.FLAGS => l10n.presenceSettings_SemanticsLabel_iconCategoryFlags,
  };
}

/// The search of the picker: the results, the field to type in and the way
/// back to the categories.
///
/// The picker's own version leaves the field with an English hint whatever the
/// language is, and the button back to the categories with no name at all.
class StatusIconSearchView extends SearchView {
  const StatusIconSearchView(super.config, super.state, super.showEmojiView, {super.key});

  @override
  SearchViewState<StatusIconSearchView> createState() => _StatusIconSearchViewState();
}

class _StatusIconSearchViewState extends SearchViewState<StatusIconSearchView> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final searchViewConfig = widget.config.searchViewConfig;

    return LayoutBuilder(
      builder: (context, constraints) {
        final emojiSize = widget.config.emojiViewConfig.getEmojiSize(constraints.maxWidth);
        final emojiBoxSize = widget.config.emojiViewConfig.getEmojiBoxSize(constraints.maxWidth);

        return Container(
          color: searchViewConfig.backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: Colors.transparent,
                child: SizedBox(
                  height: emojiBoxSize + 8.0,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: results.length,
                    itemBuilder: (context, index) => buildEmoji(results[index], emojiSize, emojiBoxSize),
                  ),
                ),
              ),
              Row(
                children: [
                  SemanticAction(
                    label: l10n.presenceSettings_SemanticsLabel_stopSearchingIcons,
                    identifier: statusIconPickerSearchCloseId,
                    child: IconButton(
                      onPressed: widget.showEmojiView,
                      color: searchViewConfig.buttonIconColor,
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Expanded(
                    child: SemanticId(
                      identifier: statusIconPickerSearchInputId,
                      child: TextField(
                        onChanged: onTextInputChanged,
                        focusNode: focusNode,
                        style: searchViewConfig.inputTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: l10n.presence_settings_statusIcon_searchHint,
                          hintStyle: searchViewConfig.hintTextStyle,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
