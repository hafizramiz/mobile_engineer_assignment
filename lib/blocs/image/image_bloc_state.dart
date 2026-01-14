import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/image_response.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object?> get props => [];
}

class FetchImageEvent extends ImageEvent {}

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object?> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final ImageResponse image;
  final Color backgroundColor;

  const ImageLoaded({required this.image, required this.backgroundColor});

  @override
  List<Object?> get props => [image, backgroundColor];
}

class ImageError extends ImageState {
  final String message;

  const ImageError(this.message);

  @override
  List<Object?> get props => [message];
}
