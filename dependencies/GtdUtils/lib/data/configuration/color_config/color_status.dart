import 'package:flutter/material.dart';

@immutable
class GtdColorStatus extends ThemeExtension<GtdColorStatus> {
  const GtdColorStatus({
    required this.success,
    required this.pending,
    required this.expired,
    required this.paymentFailed,
    required this.failed,
    required this.paymentRefunded,
    required this.cancelled,
    required this.booked,
    required this.tickedOnProcess,
    required this.paymentSuccessCommitFailed,
    required this.bookingAccepted,
    required this.bookingProcessed,
    required this.bookingPaylater,
  });

  final Color success;
  final Color pending;
  final Color expired;
  final Color paymentFailed;
  final Color failed;
  final Color paymentRefunded;
  final Color cancelled;
  final Color booked;
  final Color tickedOnProcess;
  final Color paymentSuccessCommitFailed;
  final Color bookingAccepted;
  final Color bookingProcessed;
  final Color bookingPaylater;

  @override
  GtdColorStatus copyWith({
    Color? success,
    Color? pending,
    Color? expired,
    Color? paymentFailed,
    Color? failed,
    Color? paymentRefunded,
    Color? cancelled,
    Color? booked,
    Color? tickedOnProcess,
    Color? paymentSuccessCommitFailed,
    Color? bookingAccepted,
    Color? bookingProcessed,
    Color? bookingPaylater,
  }) {
    return GtdColorStatus(
      success: success ?? this.success,
      pending: pending ?? this.pending,
      expired: expired ?? this.expired,
      paymentFailed: paymentFailed ?? this.paymentFailed,
      failed: failed ?? this.failed,
      paymentRefunded: paymentRefunded ?? this.paymentRefunded,
      cancelled: cancelled ?? this.cancelled,
      booked: booked ?? this.booked,
      tickedOnProcess: tickedOnProcess ?? this.tickedOnProcess,
      paymentSuccessCommitFailed: paymentSuccessCommitFailed ?? this.paymentSuccessCommitFailed,
      bookingAccepted: bookingAccepted ?? this.bookingAccepted,
      bookingProcessed: bookingProcessed ?? this.bookingProcessed,
      bookingPaylater: bookingPaylater ?? this.bookingPaylater,
    );
  }

  @override
  GtdColorStatus lerp(GtdColorStatus? other, double t) {
    if (other is! GtdColorStatus) {
      return this;
    }
    return GtdColorStatus(
      success: Color.lerp(success, other.success, t)!,
      pending: Color.lerp(pending, other.pending, t)!,
      expired: Color.lerp(expired, other.expired, t)!,
      paymentFailed: Color.lerp(paymentFailed, other.paymentFailed, t)!,
      failed: Color.lerp(failed, other.failed, t)!,
      paymentRefunded: Color.lerp(paymentRefunded, other.paymentRefunded, t)!,
      cancelled: Color.lerp(cancelled, other.cancelled, t)!,
      booked: Color.lerp(booked, other.booked, t)!,
      tickedOnProcess: Color.lerp(tickedOnProcess, other.tickedOnProcess, t)!,
      paymentSuccessCommitFailed:
          Color.lerp(paymentSuccessCommitFailed, other.paymentSuccessCommitFailed, t)!,
      bookingAccepted: Color.lerp(bookingAccepted, other.bookingAccepted, t)!,
      bookingProcessed: Color.lerp(bookingProcessed, other.bookingProcessed, t)!,
      bookingPaylater: Color.lerp(bookingPaylater, other.bookingPaylater, t)!,
    );
  }

  // Optional
  @override
  String toString() => 'GtdColorStatus(success: $success, pending: $pending)';
}

@immutable
class GtdColorBackgroundStatus extends ThemeExtension<GtdColorBackgroundStatus> {
  const GtdColorBackgroundStatus({
    required this.success,
    required this.pending,
    required this.expired,
    required this.paymentFailed,
    required this.failed,
    required this.paymentRefunded,
    required this.cancelled,
    required this.booked,
    required this.tickedOnProcess,
    required this.paymentSuccessCommitFailed,
    required this.bookingAccepted,
    required this.bookingProcessed,
    required this.bookingPaylater,
  });

  final Color success;
  final Color pending;
  final Color expired;
  final Color paymentFailed;
  final Color failed;
  final Color paymentRefunded;
  final Color cancelled;
  final Color booked;
  final Color tickedOnProcess;
  final Color paymentSuccessCommitFailed;
  final Color bookingAccepted;
  final Color bookingProcessed;
  final Color bookingPaylater;

  @override
  GtdColorBackgroundStatus copyWith({
    Color? success,
    Color? pending,
    Color? expired,
    Color? paymentFailed,
    Color? failed,
    Color? paymentRefunded,
    Color? cancelled,
    Color? booked,
    Color? tickedOnProcess,
    Color? paymentSuccessCommitFailed,
    Color? bookingAccepted,
    Color? bookingProcessed,
    Color? bookingPaylater,
  }) {
    return GtdColorBackgroundStatus(
      success: success ?? this.success,
      pending: pending ?? this.pending,
      expired: expired ?? this.expired,
      paymentFailed: paymentFailed ?? this.paymentFailed,
      failed: failed ?? this.failed,
      paymentRefunded: paymentRefunded ?? this.paymentRefunded,
      cancelled: cancelled ?? this.cancelled,
      booked: booked ?? this.booked,
      tickedOnProcess: tickedOnProcess ?? this.tickedOnProcess,
      paymentSuccessCommitFailed: paymentSuccessCommitFailed ?? this.paymentSuccessCommitFailed,
      bookingAccepted: bookingAccepted ?? this.bookingAccepted,
      bookingProcessed: bookingProcessed ?? this.bookingProcessed,
      bookingPaylater: bookingPaylater ?? this.bookingPaylater,
    );
  }

  @override
  GtdColorBackgroundStatus lerp(GtdColorBackgroundStatus? other, double t) {
    if (other is! GtdColorBackgroundStatus) {
      return this;
    }
    return GtdColorBackgroundStatus(
      success: Color.lerp(success, other.success, t)!,
      pending: Color.lerp(pending, other.pending, t)!,
      expired: Color.lerp(expired, other.expired, t)!,
      paymentFailed: Color.lerp(paymentFailed, other.paymentFailed, t)!,
      failed: Color.lerp(failed, other.failed, t)!,
      paymentRefunded: Color.lerp(paymentRefunded, other.paymentRefunded, t)!,
      cancelled: Color.lerp(cancelled, other.cancelled, t)!,
      booked: Color.lerp(booked, other.booked, t)!,
      tickedOnProcess: Color.lerp(tickedOnProcess, other.tickedOnProcess, t)!,
      paymentSuccessCommitFailed:
          Color.lerp(paymentSuccessCommitFailed, other.paymentSuccessCommitFailed, t)!,
      bookingAccepted: Color.lerp(bookingAccepted, other.bookingAccepted, t)!,
      bookingProcessed: Color.lerp(bookingProcessed, other.bookingProcessed, t)!,
      bookingPaylater: Color.lerp(bookingPaylater, other.bookingPaylater, t)!,
    );
  }

  // Optional
  @override
  String toString() => 'GtdColorBackgroundStatus(success: $success, pending: $pending)';
}

class GtdAppGradientColor extends ThemeExtension<GtdAppGradientColor> {
  const GtdAppGradientColor({
    required this.startColor,
    required this.endColor,
  });

  final Color startColor;
  final Color endColor;

  @override
  GtdAppGradientColor copyWith({
    Color? startColor,
    Color? endColor,
  }) {
    return GtdAppGradientColor(
      startColor: startColor ?? this.startColor,
      endColor: endColor ?? this.endColor,
    );
  }

  @override
  GtdAppGradientColor lerp(GtdAppGradientColor? other, double t) {
    if (other is! GtdAppGradientColor) {
      return this;
    }
    return GtdAppGradientColor(
      startColor: Color.lerp(startColor, other.startColor, t)!,
      endColor: Color.lerp(endColor, other.endColor, t)!,
    );
  }

  // Optional
  @override
  String toString() => 'GtdColorStatus(success: $startColor, pending: $endColor)';
}
