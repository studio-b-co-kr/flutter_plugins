part of 'login.dart';

class LoginPage extends ViewModelBuilder<LoginViewModel> {
  LoginPage({Key? key, required LoginViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, LoginViewModel read) {
    return const Scaffold(
      body: Center(
        child: Text(
          'LOG\nIN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
