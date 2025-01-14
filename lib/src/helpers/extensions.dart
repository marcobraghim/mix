import 'package:flutter/material.dart';

import '../attributes/shared/shared.descriptor.dart';
import '../factory/mix_provider.dart';
import '../factory/mix_provider_data.dart';
import '../theme/mix_theme.dart';
import '../widgets/box/box.descriptor.dart';
import '../widgets/flex/flex.descriptor.dart';
import '../widgets/icon/icon.descriptor.dart';
import '../widgets/image/image.descriptor.dart';
import '../widgets/text/text.descriptor.dart';
import '../widgets/zbox/zbox.props.dart';

extension BuildContextExt on BuildContext {
  MixData? get mix => MixProvider.of(this);

  /// MEDIA QUERY EXTENSION METHODS

  /// MediaQueryData for context
  MediaQueryData get mq => MediaQuery.of(this);

  /// Directionality of context
  TextDirection get directionality => Directionality.of(this);

  /// Orientation of the device
  Orientation get orientation => mq.orientation;

  /// Is device in landscape mode.

  bool get isLandscape => orientation == Orientation.landscape;

  /// Is device in portrait mode.

  bool get isPortrait => orientation == Orientation.portrait;

  /// Screen width
  double get screenWidth => mq.size.width;

  /// Screen height
  double get screenHeight => mq.size.height;

  // Theme Context Extensions

  Brightness get brightness => Theme.of(this).brightness;

  /// Check if brightness is Brightness.dark
  bool get isDarkMode => brightness == Brightness.dark;

  /// Theme context helpers
  ThemeData get theme => Theme.of(this);

  /// Theme color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Theme text theme
  TextTheme get textTheme => theme.textTheme;

  /// Mix Theme Data
  MixThemeData get mixTheme => MixTheme.of(this);

  @Deprecated('use SharedProps.fromContext(context) instead')
  CommonDescriptor get sharedProps =>
      CommonDescriptor.fromContext(MixProvider.of(this)!);

  @Deprecated('use BoxProps.fromContext(context) instead')
  BoxDescriptor get boxProps =>
      BoxDescriptor.fromContext(MixProvider.of(this)!);

  @Deprecated('use FlexProps.fromContext(context) instead')
  FlexDescriptor get flexProps =>
      FlexDescriptor.fromContext(MixProvider.of(this)!);

  @Deprecated('use ZBoxProps.fromContext(context) instead')
  ZBoxProps get zBoxProps => ZBoxProps.fromContext(MixProvider.of(this)!);

  @Deprecated('use IconProps.fromContext(context) instead')
  IconDescriptor get iconProps =>
      IconDescriptor.fromContext(MixProvider.of(this)!);

  @Deprecated('use TextProps.fromContext(context) instead')
  TextDescriptor get textProps =>
      TextDescriptor.fromContext(MixProvider.of(this)!);

  @Deprecated('use ImageProps.fromContext(context) instead')
  ImageDescriptor get imageProps =>
      ImageDescriptor.fromContext(MixProvider.of(this)!);
}

extension StrutStyleExt on StrutStyle {
  StrutStyle merge(StrutStyle? other) {
    return StrutStyle(
      fontFamily: other?.fontFamily ?? fontFamily,
      fontFamilyFallback: other?.fontFamilyFallback ?? fontFamilyFallback,
      fontSize: other?.fontSize ?? fontSize,
      height: other?.height ?? height,
      leadingDistribution: other?.leadingDistribution ?? leadingDistribution,
      leading: other?.leading ?? leading,
      fontWeight: other?.fontWeight ?? fontWeight,
      fontStyle: other?.fontStyle ?? fontStyle,
      forceStrutHeight: other?.forceStrutHeight ?? forceStrutHeight,
      debugLabel: other?.debugLabel ?? debugLabel,
    );
  }
}

extension Matrix4Ext on Matrix4 {
  /// Merge [other] into this matrix.
  Matrix4 merge(Matrix4? other) {
    if (other == null || other == this) return this;

    return clone()..multiply(other);
  }
}

extension IterableExt<T> on Iterable<T> {
  Iterable<T> sorted([Comparator<T>? compare]) {
    List<T> newList = List.from(this);
    newList.sort(compare);

    return newList;
  }
}

extension ListExt<T> on List<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (T element in this) {
      if (test(element)) {
        return element;
      }
    }

    return null;
  }
}
