import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vs_code_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import '../widgets/widgets.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Number Trivia'),
        ),
        body: SingleChildScrollView(child: buildBody(context)));
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(message: 'Start searching');
                } else if (state is Error) {
                  return MessageDisplay(message: state.message);
                } else if (state is Loading) {
                  return LoadingWidget();
                } else if (state is Loaded) {
                  return TriviaDisplay(numberTrivia: state.trivia);
                } else
                  return Container();
              }),
              SizedBox(
                height: 20,
              ),
             TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}
