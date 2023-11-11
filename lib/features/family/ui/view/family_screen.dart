import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makharej_app/core/navigation/route_paths.dart';
import 'package:makharej_app/core/utils/widgets/spaces.dart';
import 'package:makharej_app/features/authentication/ui/bloc/auth_bloc.dart';
import 'package:makharej_app/features/family/ui/bloc/family_screen_bloc.dart';
import 'package:makharej_app/features/family/ui/bloc/family_screen_state.dart';

import '../bloc/family_screen_event.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  bool? createFamilyIsSelected;
  late TextEditingController familyCodeController;

  @override
  void initState() {
    familyCodeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FamilyBloc, FamilyScreenState>(
        listener: familyBlocListener,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Family'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                createFamilyIsSelected = true;
                              });
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: createFamilyIsSelected == true
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                              ),
                              child: const Center(
                                child: Text('Create Family'),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                createFamilyIsSelected = false;
                              });
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: createFamilyIsSelected == false
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                              ),
                              child: const Center(
                                child: Text('Join Family'),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Spacer(flex: 2),
                      if (createFamilyIsSelected == false)
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Family Code',
                          ),
                        ),
                      Spaces.VERTICAL_XL,
                      ElevatedButton(
                        onPressed: createFamilyIsSelected != null
                            ? onGoButtonTapped
                            : null,
                        child: const Text('Go'),
                      ),
                      const Spacer(flex: 1),
                    ],
                  ),
                  if (state.isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          );
        });
  }

  void familyBlocListener(context, state) {
    if (state is FamilyScreenSuccessState) {
      RoutePaths.navigateHome();
      return;
    }
    if (state is FamilyScreenErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          state.toString(),
        )),
      );
    }
  }

  void onGoButtonTapped() {
    if (createFamilyIsSelected!) {
      BlocProvider.of<FamilyBloc>(context).add(
        FamilyScreenCreateFamilyEvent(context.read<AuthBloc>().user!),
      );
    } else {
      BlocProvider.of<FamilyBloc>(context).add(
        FamilyScreenJoinFamilyEvent(
          familyCodeController.text,
          context.read<AuthBloc>().user!,
        ),
      );
    }
  }
}
