// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentInitialImpl _$$PaymentInitialImplFromJson(Map<String, dynamic> json) =>
    _$PaymentInitialImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PaymentInitialImplToJson(
        _$PaymentInitialImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$PaymentLoadingImpl _$$PaymentLoadingImplFromJson(Map<String, dynamic> json) =>
    _$PaymentLoadingImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PaymentLoadingImplToJson(
        _$PaymentLoadingImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$PaymentFailureImpl _$$PaymentFailureImplFromJson(Map<String, dynamic> json) =>
    _$PaymentFailureImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PaymentFailureImplToJson(
        _$PaymentFailureImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$PaymentSuccessImpl _$$PaymentSuccessImplFromJson(Map<String, dynamic> json) =>
    _$PaymentSuccessImpl(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PaymentSuccessImplToJson(
        _$PaymentSuccessImpl instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ResetPinStateInitialImpl _$$ResetPinStateInitialImplFromJson(
        Map<String, dynamic> json) =>
    _$ResetPinStateInitialImpl(
      json['disabled'] as bool? ?? true,
      json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ResetPinStateInitialImplToJson(
        _$ResetPinStateInitialImpl instance) =>
    <String, dynamic>{
      'disabled': instance.disabled,
      'runtimeType': instance.$type,
    };

_$ResetPinStateLoadingImpl _$$ResetPinStateLoadingImplFromJson(
        Map<String, dynamic> json) =>
    _$ResetPinStateLoadingImpl(
      json['disabled'] as bool? ?? true,
      json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ResetPinStateLoadingImplToJson(
        _$ResetPinStateLoadingImpl instance) =>
    <String, dynamic>{
      'disabled': instance.disabled,
      'runtimeType': instance.$type,
    };

_$ResetPinStateFailureImpl _$$ResetPinStateFailureImplFromJson(
        Map<String, dynamic> json) =>
    _$ResetPinStateFailureImpl(
      json['disabled'] as bool? ?? false,
      json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ResetPinStateFailureImplToJson(
        _$ResetPinStateFailureImpl instance) =>
    <String, dynamic>{
      'disabled': instance.disabled,
      'runtimeType': instance.$type,
    };

_$ResetPinStateSuccessImpl _$$ResetPinStateSuccessImplFromJson(
        Map<String, dynamic> json) =>
    _$ResetPinStateSuccessImpl(
      json['disabled'] as bool? ?? false,
      json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ResetPinStateSuccessImplToJson(
        _$ResetPinStateSuccessImpl instance) =>
    <String, dynamic>{
      'disabled': instance.disabled,
      'runtimeType': instance.$type,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingNotifierHash() => r'7d0a1840b4912e4c91793b8212109c2d4d4d04b6';

/// See also [SettingNotifier].
@ProviderFor(SettingNotifier)
final settingNotifierProvider =
    AutoDisposeNotifierProvider<SettingNotifier, void>.internal(
  SettingNotifier.new,
  name: r'settingNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SettingNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
