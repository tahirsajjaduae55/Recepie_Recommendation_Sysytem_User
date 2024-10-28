import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:recipe_recomendation/app/index.dart';
import 'package:recipe_recomendation/presentation/common/app_button.dart';

import '../../../models/user_model.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? confirmPassword;
  String? firstName;
  String? phone;

  bool remember = false;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController firstNameCtrl = TextEditingController();

  TextEditingController passCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? fireBaseuser;
  final DatabaseReference userRefernece =
      FirebaseDatabase.instance.ref().child('Users');

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
              Text(
                'Welcome',
                style: TextStyleManager.popinsSemBold(
                  fontSize: 34.sp,
                ),
              ),
              const SizedBox(height: (16)),
              Text(
                'Create a New Account',
                style: TextStyleManager.popinsSemBold(
                  fontSize: 20.sp,
                ),
              ),
              const SizedBox(height: (24)),
              buildFirstNameFormField(),
              const SizedBox(height: (8)),
              buildEmailFormField(),
              const SizedBox(height: (8)),
              buildPhoneFormField(),
              const SizedBox(height: (8)),
              buildPasswordFormField(),
              const SizedBox(height: (8)),
              AppButton(
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    //TODO:SIGNUP
                    signupwithFirebase();
                  }
                },
                text: 'Sign Up',
              ),
              const SizedBox(height: (48)),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an account',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Login',
                                style: const TextStyle(
                                    color: Colors.blueAccent, fontSize: 18),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // navigate to SIgnup screen

                                    Navigator.pushNamed(
                                        context, Routes.loginRoute);
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

  signupwithFirebase() async {
    try {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailCtrl.text,
        password: passCtrl.text,
      );
      fireBaseuser = credential.user;
      await fireBaseuser!.reload();
      fireBaseuser = _auth.currentUser;
      saveUserToFirebase();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  saveUserToFirebase() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // var pushId = userRefernece.push();

      UserModel userModel = UserModel.withId(fireBaseuser!.uid,
          firstNameCtrl.text, phoneCtrl.text, emailCtrl.text, passCtrl.text);

      await userRefernece
          .child(fireBaseuser!.uid.toString())
          .set(userModel.toJson())
          .then(
        (value) {
          setState(() {
            firstNameCtrl.text = '';
          });
          Navigator.pushNamed(context, Routes.loginRoute);
        },
      );
    }
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: firstNameCtrl,
      textInputAction: TextInputAction.next,
      cursorColor: ColorManager.primary,
      keyboardType: TextInputType.name,
      onSaved: (newValue) => firstName = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return Utils.kNamelNullError;
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: ColorManager.primary),
        ),
        labelStyle: TextStyle(color: ColorManager.primary),
        focusColor: ColorManager.primary,
        hintText: "First Name",
        filled: true,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailCtrl,
      textInputAction: TextInputAction.next,
      cursorColor: ColorManager.primary,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          //removeError(error: kEmailNullError);
          setState(() {
            //  _formKey.currentState!.validate();
          });
        } else if (Utils.emailValidatorRegExp.hasMatch(value)) {
          // removeError(error: kInvalidEmailError);
          // _formKey.currentState!.validate();
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          //addError(error: kEmailNullError);
          return Utils.kEmailNullError;
        } else if (!Utils.emailValidatorRegExp.hasMatch(value)) {
          // addError(error: kInvalidEmailError);
          return Utils.kInvalidEmailError;
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: ColorManager.primary),
        ),
        labelStyle: TextStyle(color: ColorManager.primary),
        focusColor: ColorManager.primary,
        hintText: "Enter email",
        filled: true,
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      controller: phoneCtrl,
      cursorColor: ColorManager.primary,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => phone = newValue!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter';
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: ColorManager.primary),
        ),
        labelStyle: TextStyle(color: ColorManager.primary),
        focusColor: ColorManager.primary,
        hintText: "Phone Number",
        filled: true,
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passCtrl,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      obscureText: _obscureText,
      enableSuggestions: false,
      cursorColor: ColorManager.primary,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          // removeError(error: kPassNullError);
          setState(() {
            // _formKey.currentState!.validate();
          });
        } else if (value.length >= 8) {
          // removeError(error: kShortPassError);
          setState(() {
            //  _formKey.currentState!.validate();
          });
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          //addError(error: kPassNullError);

          return Utils.kPassNullError;
        } else if (value.length < 8) {
          //addError(error: kShortPassError);
          return Utils.kShortPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: ColorManager.primary),
        ),
        hintText: "Enter your password",
        filled: true,
        labelStyle: TextStyle(color: ColorManager.primary),
        suffixIcon: GestureDetector(
          onTap: _toggle,
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: ColorManager.black,
          ),
        ),
      ),
    );
  }
}
