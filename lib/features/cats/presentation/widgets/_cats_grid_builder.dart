part of 'cats_view.dart';

/// [_CatsGridBuilder] is a private class that builds a grid view of cats.
/// It takes a list of [Cat] objects and displays them in a grid view.
/// Only [CatsView] can access this class.
final class _CatsGridBuilder extends StatelessWidget {
  final List<Cat> cats;

  const _CatsGridBuilder({super.key, required this.cats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.catGridPadding),
      child: MasonryGridView.count(
        itemCount: cats.length,
        crossAxisCount: AppSize.crossAxisCount,
        mainAxisSpacing: AppSize.mainAxisSpacing,
        crossAxisSpacing: AppSize.crossAxisSpacing,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _CatDetailsDialog(cats[index].id);
                },
              );
            },
            child: Image.network(
              cats[index]!.url!,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

final class _CatDetailsDialog extends StatelessWidget {
  final String? selectedCatId;

  _CatDetailsDialog(this.selectedCatId);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.catDetails),
      content: Text('${AppStrings.selectedCatid} ${selectedCatId ?? ""}'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppStrings.close),
        ),
      ],
    );
  }
}
