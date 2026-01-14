import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../services/api_service.dart';
import 'image_bloc_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ApiService _apiService;

  ImageBloc(this._apiService) : super(ImageInitial()) {
    on<FetchImageEvent>(_onFetchImage);
  }

  Future<void> _onFetchImage(
    FetchImageEvent event,
    Emitter<ImageState> emit,
  ) async {
    emit(ImageLoading());
    try {
      final imageResponse = await _apiService.getRandomImage();

      // Extract color from image
      final paletteGenerator =
          await PaletteGenerator.fromImageProvider(
            CachedNetworkImageProvider(imageResponse.url),
            maximumColorCount: 20,
          ).timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              throw Exception('Color extraction timed out');
            },
          );

      final backgroundColor =
          paletteGenerator.dominantColor?.color ?? Colors.grey;

      emit(ImageLoaded(image: imageResponse, backgroundColor: backgroundColor));
    } catch (e) {
      emit(ImageError(e.toString()));
    }
  }
}
