import 'package:car_rental/widgets/button_widget.dart';
import 'package:car_rental/widgets/go_back.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email = '';

  final _emailKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xff0d141c) : Colors.white,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.025,
                          vertical: size.height * 0.01,
                        ),
                        child: buildGoBack(
                          () => Navigator.pop(context),
                          isDarkMode,
                          context,
                          size,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.05,
                          left: size.width * 0.055,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Reset password',
                            style: GoogleFonts.poppins(
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff1D1617),
                              fontSize: size.height * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.055,
                        ),
                        child: Align(
                          child: Text(
                            "Forgot your password? That's okay, it happens to everyone!\nPlease provide your email to reset your password.",
                            style: GoogleFonts.poppins(
                              color:
                                  isDarkMode ? Colors.white54 : Colors.black54,
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                      ),
                      Form(
                        child: buildTextField(
                          "Email",
                          Icons.email_outlined,
                          false,
                          size,
                          (valuemail) {
                            if (valuemail.length < 5) {
                              buildSnackError(
                                'Invalid email',
                                context,
                                size,
                              );
                              return '';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                .hasMatch(valuemail)) {
                              buildSnackError(
                                'Invalid email',
                                context,
                                size,
                              );
                              return '';
                            }
                            return null;
                          },
                          isDarkMode,
                          _emailController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.025),
                        child: ButtonWidget(
                          cooldown: const Duration(
                            seconds: 5,
                          ),
                          text: 'Send Instruction',
                          height: size.height * 0.07,
                          width: size.width * 0.9,
                          borderRadius: 15,
                          backColors: isDarkMode
                              ? [
                                  Colors.black,
                                  Colors.black,
                                ]
                              : const [
                                  Color(0xff92A3FD),
                                  Color(0xff9DCEFF),
                                ],
                          textColors: const [
                            Colors.white,
                            Colors.white,
                          ],
                          onPressed: () async {
                            if (_emailKey.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email);

                                buildSnackError(
                                  "Check your email for password reset link",
                                  context,
                                  size,
                                );
                              } on FirebaseAuthException catch (authEx) {
                                if (authEx.code == "insufficient-permission") {
                                  buildSnackError(
                                    "You don't have enough permission",
                                    context,
                                    size,
                                  );
                                } else if (authEx.code == "invalid-email") {
                                  buildSnackError(
                                    "Invalid email adress",
                                    context,
                                    size,
                                  );
                                } else if (authEx.code == "user-not-found") {
                                  buildSnackError(
                                    "This account doesn't exist",
                                    context,
                                    size,
                                  );
                                } else if (authEx.code ==
                                    "insufficient-permission") {
                                  buildSnackError(
                                    "You don't have enough permission",
                                    context,
                                    size,
                                  );
                                } else {
                                  buildSnackError(
                                    "Something went wrong, check your connection",
                                    context,
                                    size,
                                  );
                                }
                              }
                            }
                            _emailController.clear();
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.08),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool pwVisible = false;
  Widget buildTextField(
    String hintText,
    IconData icon,
    bool password,
    size,
    FormFieldValidator validator,
    bool isDarkMode,
    TextEditingController controller,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.025),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : const Color(0xffF7F8F8),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Form(
          key: _emailKey,
          child: TextFormField(
            controller: controller,
            style: TextStyle(
              color: isDarkMode ? const Color(0xffADA4A5) : Colors.black,
            ),
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            validator: validator,
            textInputAction: TextInputAction.next,
            obscureText: password ? !pwVisible : false,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(
                color: Color(0xffADA4A5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                top: size.height * 0.02,
              ),
              hintText: hintText,
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.005,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xff7B6F72),
                ),
              ),
              suffixIcon: password
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.005,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pwVisible = !pwVisible;
                          });
                        },
                        child: pwVisible
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                color: Color(0xff7B6F72),
                              )
                            : const Icon(
                                Icons.visibility_outlined,
                                color: Color(0xff7B6F72),
                              ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackError(
      String error, context, size) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: SizedBox(
          height: size.height * 0.02,
          child: Center(
            child: Text(error),
          ),
        ),
      ),
    );
  }
}
