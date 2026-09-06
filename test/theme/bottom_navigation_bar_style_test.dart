import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/features/main/widgets/widgets.dart';
import 'package:webtrit_phone/theme/factory/theme_style_factory_provider.dart';

/// What a brand asks of the bottom bar, and what the bar does with it.
///
/// The bar used to reach past its own theme twice - it drew the background at
/// `withAlpha(200)`, and it handed both label styles `bodySmall`, whose colour
/// Flutter uses *instead of* the selected and unselected item colours. So two
/// of the three colours the editor offers painted icons and nothing else, and
/// the third could not be reached at all: the darkest a dark bar could get
/// over a light page was that page lightened by a fifth.
void main() {
  const brandBackground = Color(0xFF0F1822);
  const brandSelected = Color(0xFF58CCEB);
  const brandUnselected = Color(0xFFF4E9E3);

  ThemeData themeFrom(BottomNavigationBarWidgetConfig bar) {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF0F1822),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF58CCEB),
      onSecondary: Color(0xFF0F1822),
      error: Color(0xFFB3261E),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFF8FBFD),
      onSurface: Color(0xFF0F1822),
    );
    final style = ThemeStyleFactoryProvider(
      colorScheme: scheme,
      widgetConfig: ThemeWidgetConfig(bar: BarWidgetConfig(bottomNavigationBar: bar)),
      pageConfig: const ThemePageConfig(),
      seedThemeData: ThemeData.light(),
    );

    return ThemeData.from(
      colorScheme: scheme,
      textTheme: style.defaultTextTheme,
      useMaterial3: true,
    ).copyWith(bottomNavigationBarTheme: style.createBottomNavigationBarThemeData());
  }

  Future<void> pumpBar(WidgetTester tester, ThemeData theme) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          bottomNavigationBar: MainBottomNavigationBar(
            tabs: const [
              FavoritesBottomMenuTab(enabled: true, initial: true, titleL10n: 'Favorites', icon: Icons.star),
              RecentsBottomMenuTab(
                enabled: true,
                initial: false,
                titleL10n: 'Recents',
                icon: Icons.history,
                supportsCallHistory: true,
              ),
            ],
            currentIndex: 0,
            onTap: null,
          ),
        ),
      ),
    );
  }

  Color? backgroundOf(WidgetTester tester) => tester
      .widget<Material>(find.descendant(of: find.byType(BottomNavigationBar), matching: find.byType(Material)).first)
      .color;

  Color? labelColourOf(WidgetTester tester, String caption) => tester
      .widget<RichText>(find.descendant(of: find.text(caption), matching: find.byType(RichText)).first)
      .text
      .style
      ?.color;

  testWidgets('paints the background the brand named, and nothing over it', (tester) async {
    await pumpBar(tester, themeFrom(const BottomNavigationBarWidgetConfig(backgroundColor: '#0F1822')));

    expect(backgroundOf(tester), brandBackground);
  });

  testWidgets('lets a brand ask for a see-through bar in the colour itself', (tester) async {
    await pumpBar(tester, themeFrom(const BottomNavigationBarWidgetConfig(backgroundColor: '#CC0F1822')));

    expect(backgroundOf(tester)?.a, closeTo(0xCC / 0xFF, 0.01));
  });

  testWidgets('paints the captions with the item colours', (tester) async {
    await pumpBar(
      tester,
      themeFrom(
        const BottomNavigationBarWidgetConfig(
          backgroundColor: '#0F1822',
          selectedItemColor: '#58CCEB',
          unSelectedItemColor: '#F4E9E3',
        ),
      ),
    );

    expect(labelColourOf(tester, 'Favorites'), brandSelected);
    expect(labelColourOf(tester, 'Recents'), brandUnselected);
  });

  testWidgets('a label style of its own wins, which is how captions differ from icons', (tester) async {
    await pumpBar(
      tester,
      themeFrom(
        const BottomNavigationBarWidgetConfig(
          selectedItemColor: '#58CCEB',
          selectedLabelStyle: TextStyleConfig(color: '#FF0000'),
        ),
      ),
    );

    expect(labelColourOf(tester, 'Favorites'), const Color(0xFFFF0000));
  });
}
