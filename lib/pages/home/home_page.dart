import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../blocs/image/image_bloc.dart';
import '../../blocs/image/image_bloc_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I.get<ImageBloc>()..add(FetchImageEvent()),
      child: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
          if (state is ImageLoaded) {
            backgroundColor = state.backgroundColor;
          }

          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: backgroundColor,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildImageFrame(state),
                      const SizedBox(height: 40),
                      Semantics(
                        button: true,
                        label: 'Fetch another random image',
                        child: ElevatedButton(
                          onPressed: state is ImageLoading
                              ? null
                              : () => context.read<ImageBloc>().add(
                                  FetchImageEvent(),
                                ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Another',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageFrame(ImageState state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double size = constraints.maxWidth * 0.8;
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Semantics(
            label: state is ImageLoaded
                ? 'Randomly fetched image'
                : 'Image container',
            child: _buildImageContent(state),
          ),
        );
      },
    );
  }

  Widget _buildImageContent(ImageState state) {
    if (state is ImageLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ImageLoaded) {
      return CachedNetworkImage(
        imageUrl: state.image.url,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error, size: 50),
        fadeInDuration: const Duration(milliseconds: 500),
      );
    } else if (state is ImageError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            state.message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
