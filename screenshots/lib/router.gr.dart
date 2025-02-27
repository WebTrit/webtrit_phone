// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint, unused_element_parameter
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    IndexInputRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<IndexInputRouteArgs>(
          orElse: () => IndexInputRouteArgs(index: pathParams.getInt('initialIndex')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: IndexInputScreen(
          key: args.key,
          index: args.index,
        ),
      );
    }
  };
}

/// generated route for
/// [IndexInputScreen]
class IndexInputRoute extends PageRouteInfo<IndexInputRouteArgs> {
  IndexInputRoute({
    Key? key,
    required int index,
    List<PageRouteInfo>? children,
  }) : super(
          IndexInputRoute.name,
          args: IndexInputRouteArgs(
            key: key,
            index: index,
          ),
          rawPathParams: {'initialIndex': index},
          initialChildren: children,
        );

  static const String name = 'IndexInputRoute';

  static const PageInfo<IndexInputRouteArgs> page = PageInfo<IndexInputRouteArgs>(name);
}

class IndexInputRouteArgs {
  const IndexInputRouteArgs({
    this.key,
    required this.index,
  });

  final Key? key;

  final int index;

  @override
  String toString() {
    return 'IndexInputRouteArgs{key: $key, index: $index}';
  }
}
