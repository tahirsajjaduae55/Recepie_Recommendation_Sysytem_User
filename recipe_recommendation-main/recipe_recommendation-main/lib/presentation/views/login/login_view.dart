import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:recipe_recomendation/app/index.dart';
import 'package:recipe_recomendation/presentation/common/app_button.dart';

import '../../common/config.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool isLoading = false;

  String? email, password;

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 96,
                height: 96,
              ),
              const SizedBox(height: (16)),
              Center(
                child: Text(
                  'Welcome',
                  style: TextStyleManager.popinsSemBold(
                    fontSize: 34.sp,
                  ),
                ),
              ),
              const SizedBox(height: (16)),
              Center(
                child: Text(
                  'Login',
                  style: TextStyleManager.popinsSemBold(),
                ),
              ),
              const SizedBox(height: (24)),
              buildEmailField(),
              const SizedBox(height: (16)),
              buildPasswordField(),
              const SizedBox(height: (16)),
              isLoading
                  ? SpinKitCircle(
                      color: ColorManager.primary,
                    )
                  : AppButton(
                      onPress: () {
                        // if (emailCtrl.text == 'admin@admin.com' &&
                        //     passwordCtrl.text == 'admin123') {}
                        setState(() {
                          isLoading = true;
                        });

                        loginwithFirebase();
                      },
                      text: 'Login',
                    ),
              const SizedBox(height: (48)),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Sign up',
                                style: const TextStyle(
                                    color: Colors.blueAccent, fontSize: 18),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // navigate to SIgnup screen

                                    Navigator.pushNamed(
                                        context, Routes.usersignUpRoute);
                                  }),
                          ]),
                    ),
                  ))
            ],
          )),
        ),
      ),
    );
  }

  checkAuthentication() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        if (box!.get('login') == true) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homeRoute, (Route route) => false);
        }
      }
    });
  }

  loginwithFirebase() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailCtrl.text,
          password: passwordCtrl.text,
        );
        User? user = credential.user;
        user = _auth.currentUser;
        if (user != null) {
          box!.put('login', true);
          gotToHomeScreen();
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Utils.toastMessage('No user found');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Utils.toastMessage('wrong passwords');

          print('Wrong password provided for that user.');
        }
      } finally {
        setState(() {
          isLoading = false; // Hide loading indicator
        });
      }
    } else {
      Utils.toastMessage('Something went wrong');

      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  gotToHomeScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.homeRoute, (Route route) => false);
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: emailCtrl,
      textInputAction: TextInputAction.next,
      onSaved: (newValue) {
        email = newValue;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email is required';
        } else if (!Utils.emailValidatorRegExp.hasMatch(value)) {
          return Utils.kInvalidEmailError;
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorManager.primary),
        ),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: passwordCtrl,
      textInputAction: TextInputAction.done,
      onSaved: (newValue) {
        password = newValue;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return Utils.kPassNullError;
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.password),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorManager.primary),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ColorManager.primary),
        ),
      ),
    );
  }
}
