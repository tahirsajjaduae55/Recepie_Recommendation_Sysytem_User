import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:recipe_recomendation/app/index.dart';
import 'package:recipe_recomendation/presentation/common/app_button.dart';

import '../../common/config.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  static String routeName = "/edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // final DatabaseReference _databaseReference =
  //     FirebaseDatabase.instance.ref().child('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentFirebaseUser;
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

  // final ImagePicker _picker = ImagePicker();
  // File? _selectedImage;
  // String imageUrl = 'empty';
  // String? fileName;

  @override
  void initState() {
    super.initState();
    currentFirebaseUser = _auth.currentUser;
    if (box!.get('login') == true) {
      emailCtrl = TextEditingController(text: box!.get('email'));
      firstNameCtrl = TextEditingController(text: box!.get('firstName'));

      phoneCtrl = TextEditingController(text: box!.get('phone'));
    }

    print('imageUrl');

    print('boxValue');
    print(box!.get('photourl'));
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
              const SizedBox(height: (48)),
              Utils.popinSemBoldText(
                'Update your Profile Info',
                fontSize: 20.sp,
              ),
              const SizedBox(height: (24)),
              buildFirstNameFormField(),
              const SizedBox(height: (8)),
              buildEmailFormField(),
              const SizedBox(height: (8)),
              buildPhoneFormField(),
              const SizedBox(height: (24)),
              AppButton(
                onPress: () {
                  updateUserProfile();
                },
                text: 'Update',
              ),
              const SizedBox(height: (48)),
            ],
          )),
        ),
      ),
    );
  }

  //Update profile to firebase
  Future<void> updateUserProfile() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("Users").child(currentFirebaseUser!.uid);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await ref.update({
        "firstName": firstNameCtrl.text,
        "phone": phoneCtrl.text,
      }).then(
        (value) {
          Navigator.of(context).pop();
        },
      );
    } else {
      print('Error Updating Profile');
    }
  }

  //Camera Method

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
      readOnly: true,
      // enabled: false,
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
}
