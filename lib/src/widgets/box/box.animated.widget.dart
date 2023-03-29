import 'package:flutter/material.dart';

import '../../attributes/common/common.descriptor.dart';
import '../../decorators/decorator_wrapper.widget.dart';
import '../../mixer/mix_factory.dart';
import '../../variants/variant.dart';
import '../mix.widget.dart';
import '../mix_context_builder.dart';
import '../nothing.widget.dart';
import 'box.descriptor.dart';

class AnimatedBox extends MixWidget {
  const AnimatedBox({
    Mix? mix,
    Key? key,
    bool? inherit,
    List<Variant>? variants,
    this.child,
  }) : super(
          mix,
          variants: variants,
          inherit: inherit,
          key: key,
        );

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MixContextBuilder(
      mix: mix,
      inherit: inherit,
      variants: variants,
      builder: (context, mixContext) {
        final boxProps = BoxDescriptor.fromContext(context);
        final commonProps = CommonDescriptor.fromContext(context);

        return AnimatedBoxMixedWidget(
          boxProps: boxProps,
          commonProps: commonProps,
          child: child,
        );
      },
    );
  }
}

class AnimatedBoxMixedWidget extends StatelessWidget {
  const AnimatedBoxMixedWidget({
    required this.boxProps,
    required this.commonProps,
    this.child,
    Key? key,
  }) : super(key: key);

  final BoxDescriptor boxProps;
  final CommonDescriptor commonProps;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (!commonProps.visible) {
      return const Nothing();
    }

    Widget current = AnimatedContainer(
      color: boxProps.color,
      decoration: boxProps.decoration,
      alignment: boxProps.alignment,
      constraints: boxProps.constraints,
      margin: boxProps.margin,
      padding: boxProps.padding,
      height: boxProps.height,
      width: boxProps.width,
      duration: commonProps.animationDuration,
      curve: commonProps.animationCurve,
      transform: boxProps.transform,
      child: child,
    );

    // Wrap parent decorators
    if (boxProps.decorators != null) {
      current = DecoratorWrapper(
        boxProps.decorators!,
        child: current,
      );
    }

    return current;
  }
}
