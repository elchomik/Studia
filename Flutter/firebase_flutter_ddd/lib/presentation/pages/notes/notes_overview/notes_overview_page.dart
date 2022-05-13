import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_flutter_ddd/application/auth/bloc/auth_bloc.dart';
import 'package:firebase_flutter_ddd/application/notes/note_actor/bloc/note_actor_bloc.dart';
import 'package:firebase_flutter_ddd/application/notes/note_watcher/bloc/note_watcher_bloc.dart';
import 'package:firebase_flutter_ddd/injection.dart';
import 'package:firebase_flutter_ddd/presentation/pages/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:firebase_flutter_ddd/presentation/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesOverviewPage extends StatelessWidget {
  const NotesOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(create: (context) => getIt<NoteActorBloc>())
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  unauthenticated: (_) =>
                      AutoRouter.of(context).push(const SignInPageRoute()));
            },
          ),
          BlocListener<NoteActorBloc, NoteActorState>(
              listener: (context, state) {
            state.maybeMap(
                orElse: () {},
                deleteFailure: (state) {
                  FlushbarHelper.createError(
                          duration: const Duration(seconds: 5),
                          message: state.noteFailure.map(
                              unexpected: (_) =>
                                  'Unexpected error occured while deleting',
                              insufficientPermission: (_) =>
                                  'Insufficient permissions',
                              unableToUpdate: (_) => 'Impossible error'))
                      .show(context);
                });
          })
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
              },
              icon: const Icon(Icons.exit_to_app),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.indeterminate_check_box))
            ],
          ),
          body: NotesOverviewBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //TODO: Navigate to NoteFormPage
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
