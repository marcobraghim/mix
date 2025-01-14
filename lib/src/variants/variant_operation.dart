import 'package:flutter/foundation.dart';

import '../attributes/attribute.dart';
import '../attributes/nested_attribute.dart';
import '../factory/mix_factory.dart';
import 'context_variant.dart';
import 'variant.dart';
import 'variant_attribute.dart';

enum EnumVariantOperator { and, or }

class VariantOperation {
  final List<Variant> variants;
  final EnumVariantOperator operator;

  const VariantOperation(
    this.variants, {
    required this.operator,
  });

  VariantOperation operator &(Variant variant) {
    if (operator != EnumVariantOperator.and) {
      throw ArgumentError('All the operators in the equation must be the same');
    }

    variants.add(variant);

    return this;
  }

  VariantOperation operator |(Variant variant) {
    if (operator != EnumVariantOperator.or) {
      throw ArgumentError('All the operators in the equation must be the same');
    }

    variants.add(variant);

    return this;
  }

  List<VariantAttribute> _buildOrOperations(
    List<Attribute> attributes, {
    Iterable<Variant>? variants,
  }) {
    variants ??= this.variants;
    final style = Mix.fromAttributes(attributes);
    final attributeVariants = variants.map((variant) {
      return variant is ContextVariant
          ? ContextVariantAttribute(variant, style)
          : VariantAttribute(variant, style);
    });

    return attributeVariants.toList();
  }

  List<VariantAttribute> _buildAndOperations(
    List<Attribute> attributes,
  ) {
    final attributeVariants = variants.map((variant) {
      final otherVariants = variants.where((otherV) => otherV != variant);
      final mixToApply = Mix.fromAttributes(
        _buildOrOperations(
          attributes,
          variants: otherVariants,
        ),
      );

      return variant is ContextVariant
          ? ContextVariantAttribute(variant, mixToApply)
          : VariantAttribute(variant, mixToApply);
    });

    return attributeVariants.toList();
  }

  // ignore: long-parameter-list
  NestedMixAttribute<VariantAttribute> call([
    Attribute? p1,
    Attribute? p2,
    Attribute? p3,
    Attribute? p4,
    Attribute? p5,
    Attribute? p6,
    Attribute? p7,
    Attribute? p8,
    Attribute? p9,
    Attribute? p10,
    Attribute? p11,
    Attribute? p12,
  ]) {
    final params = <Attribute>[];
    for (final param in [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12]) {
      if (param != null) params.add(param);
    }

    List<VariantAttribute> attributes = [];
    if (operator == EnumVariantOperator.and) {
      attributes = _buildAndOperations(params);
    } else if (operator == EnumVariantOperator.or) {
      attributes = _buildOrOperations(params);
    }

    return NestedMixAttribute<VariantAttribute>(Mix.fromAttributes(attributes));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VariantOperation &&
        listEquals(other.variants, variants) &&
        other.operator == operator;
  }

  @override
  int get hashCode => variants.hashCode ^ operator.hashCode;

  @override
  String toString() => 'MultiVariant(variants: $variants, operator: $operator)';
}
