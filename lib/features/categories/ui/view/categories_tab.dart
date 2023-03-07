import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makharej_app/features/categories/ui/bloc/categories_bloc.dart';
import 'package:makharej_app/features/categories/ui/bloc/categories_event.dart';
import 'package:makharej_app/features/categories/ui/bloc/categories_state.dart';

import 'widgets/categories_grid.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CategoriesBloc>().add(CategoryFetchListEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, CategoryState>(
        listener: (context, state) {},
        bloc: BlocProvider.of<CategoriesBloc>(context),
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CustomScrollView(
                    slivers: [
                      const SliverPadding(
                        padding: EdgeInsets.all(8.0),
                        sliver: SliverToBoxAdapter(
                          child: Text("Expenses Categories"),
                        ),
                      ),
                      const SliverPadding(padding: EdgeInsets.all(8.0)),
                      CategoriesGrid(categories: state.categories),
                    ],
                  ),
                ),
                if (state is CategoriesLoadingState)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          );
        });
  }
}
