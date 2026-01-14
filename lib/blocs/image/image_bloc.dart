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
      final imageUrl = imageResponse.url;

      // 1. Emit immediate state with image and default background
      // This allows the image to start loading in the UI immediately
      emit(
        ImageLoaded(
          image: imageResponse,
          backgroundColor: Colors.grey.withValues(alpha: 0.1),
        ),
      );

      // 2. Perform color extraction in the background
      try {
        // Optimize URL for faster download if it's an Unsplash URL
        String thumbUrl = imageUrl;
        try {
          if (imageUrl.contains('unsplash.com')) {
            final uri = Uri.parse(imageUrl);
            final params = Map<String, String>.from(uri.queryParameters);
            params['w'] = '100';
            params['q'] = '50';
            thumbUrl = uri.replace(queryParameters: params).toString();
          }
        } catch (e) {
          // Fallback to original URL if parsing fails
        }

        final paletteGenerator = await PaletteGenerator.fromImageProvider(
          CachedNetworkImageProvider(thumbUrl),
          maximumColorCount: 20,
        ).timeout(const Duration(seconds: 5));

        final backgroundColor =
            paletteGenerator.dominantColor?.color ?? Colors.grey;

        // 3. Emit updated state with the extracted color
        if (!isClosed) {
          emit(
            ImageLoaded(image: imageResponse, backgroundColor: backgroundColor),
          );
        }
      } catch (e) {
        // Silent fail for optional color extraction to reduce console noise
        // The image will still be displayed with the fallback background
      }
    } catch (e) {
      if (!isClosed) {
        emit(ImageError(e.toString()));
      }
    }
  }
}
