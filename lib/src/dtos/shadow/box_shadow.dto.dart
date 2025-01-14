import 'package:flutter/material.dart';

import '../../factory/mix_provider_data.dart';
import '../../helpers/mergeable_list.dart';
import '../color.dto.dart';
import 'shadow.dto.dart';

class BoxShadowDto extends ShadowDto<BoxShadow> {
  final double? spreadRadius;

  const BoxShadowDto({
    super.color,
    super.offset,
    super.blurRadius,
    this.spreadRadius,
  });

  factory BoxShadowDto.fromBoxShadow(BoxShadow? boxShadow) {
    if (boxShadow == null) {
      return const BoxShadowDto();
    }

    return BoxShadowDto(
      blurRadius: boxShadow.blurRadius,
      color: ColorDto.maybeFrom(boxShadow.color),
      offset: Offset(boxShadow.offset.dx, boxShadow.offset.dy),
      spreadRadius: boxShadow.spreadRadius,
    );
  }

  @override
  BoxShadow resolve(MixData mix) {
    return BoxShadow(
      color: color?.resolve(mix) ?? const BoxShadow().color,
      offset: offset ?? const BoxShadow().offset,
      blurRadius: blurRadius ?? const BoxShadow().blurRadius,
      spreadRadius: spreadRadius ?? const BoxShadow().spreadRadius,
    );
  }

  @override
  BoxShadowDto copyWith({
    ColorDto? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
  }) {
    return BoxShadowDto(
      color: color ?? this.color,
      offset: offset ?? this.offset,
      blurRadius: blurRadius ?? this.blurRadius,
      spreadRadius: spreadRadius ?? this.spreadRadius,
    );
  }

  @override
  BoxShadowDto merge(BoxShadowDto? other) {
    return copyWith(
      color: other?.color,
      offset: other?.offset,
      blurRadius: other?.blurRadius,
      spreadRadius: other?.spreadRadius,
    );
  }

  @override
  get props => [color, offset, blurRadius, spreadRadius];
}

extension BoxShadowDtoExt on List<BoxShadowDto> {
  List<BoxShadow> resolve(MixData mix) {
    return map((e) => e.resolve(mix)).toList();
  }

  List<BoxShadowDto> merge(List<BoxShadowDto>? other) {
    return combineMergeableLists(this, other);
  }
}
