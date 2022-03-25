part of 'onboarding.dart';

class OnboardingPage extends ViewModelBuilder<OnboardingViewModel> {
  OnboardingPage({Key? key, required OnboardingViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, OnboardingViewModel read) {
    return const Scaffold(
      body: Center(
        child: Text(
          'FORCE\nUPDATE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
