import 'dart:ui';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

/// Height of the row of categories, and of every tab in it: a target smaller
/// than this cannot be hit reliably.
const double _categoryTabSize = kMinInteractiveDimension;

/// The sheet that picks the icon shown next to the presence status.
///
/// Closes with the chosen emoji, or with nothing when it is dismissed.
class StatusIconPickerDialog extends StatelessWidget {
  const StatusIconPickerDialog({super.key});

  static Future<String?> show(BuildContext context) {
    return showDialog<String>(context: context, builder: (context) => const StatusIconPickerDialog());
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        shadowColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
          clipBehavior: Clip.hardEdge,
          width: 300,
          height: 300,
          child: EmojiPicker(
            config: Config(
              emojiViewConfig: const EmojiViewConfig(backgroundColor: Colors.white, emojiSizeMax: 20),
              categoryViewConfig: CategoryViewConfig(
                tabBarHeight: _categoryTabSize,
                customCategoryView: (config, state, tabController, pageController) =>
                    StatusIconCategoryView(config, state, tabController, pageController),
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
