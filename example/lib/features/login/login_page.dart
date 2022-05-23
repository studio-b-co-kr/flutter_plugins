part of 'login.dart';

class LoginPage extends ViewModelBuilder<LoginViewModel> {
  static const routeName = '/login';
  LoginPage({Key? key, required LoginViewModel viewModel})
      : super(key: key, viewModel: viewModel);

  @override
  Widget build(BuildContext context, LoginViewModel read) {
    return Scaffold(
      body: Column(children: [
        const Expanded(
          child: Center(
            child: Text(
              'LOG-IN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: MaterialButton(
            height: 48,
            minWidth: double.infinity,
            color: Colors.grey,
            onPressed: () {
              read.goNext();
            },
            child: Text(
              'GO NEXT',
              style: TextStyle(
                color: Colors.grey.shade50,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
