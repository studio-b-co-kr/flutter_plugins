part of 'intro.dart';

class IntroPage extends ViewModelBuilder<IntroViewModel> {
  IntroPage({Key? key, required IntroViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, IntroViewModel read) {
    return const Scaffold(
      body: Center(
        child: Text(
          'INTRO.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
