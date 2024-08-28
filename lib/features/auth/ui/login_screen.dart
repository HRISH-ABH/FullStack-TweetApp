import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tweetapp/features/auth/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool showPass = false;
  // TextEditingController userNameController = TextEditingController();

  final _formKey = Key('form');
  bool _isLogin = true;

  AuthBloc authBloc = AuthBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      // appBar: AppBar(
      //   leading: Container(),
      //   centerTitle: true,
      //   title: Container(
      //     // Logo

      //     // Text
      //     child: const Text(
      //       "Login Screen",
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          bloc: authBloc,
          listenWhen: (previous, current) => current is AuthActionState,
          buildWhen: (previous, current) => current is! AuthActionState,
          listener: (context, state) {
            // TODO: implement listener
            if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            } else if (state == AuthSuccessState) {
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    // Hello
                    Gap(20),
                    Text(
                      "Hey ! Again",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    Gap(10),
                    Text(
                      "Welcome Back! You have been Missed",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Gap(15),
                    // email textfield
                    if (!_isLogin)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 14),
                            child: TextFormField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter your Name";
                                } else {
                                  return null;
                                }
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Name'),
                            ),
                          ),
                        ),
                      ),
                    Gap(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter your email";
                              } else {
                                return null;
                              }
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                    ),
                    Gap(10),
                    // pass textField
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: TextFormField(
                            obscureText: !showPass,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter your email";
                              } else {
                                return null;
                              }
                            },
                            controller: passController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(showPass
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      showPass = !showPass;
                                    });
                                  },
                                )),
                          ),
                        ),
                      ),
                    ),
                    Gap(20),
                    //SignIn Button
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          authBloc.add(
                            AuthenticationEvent(
                              authType:
                                  _isLogin ? AuthType.login : AuthType.register,
                              email: emailController.text,
                              pass: passController.text,
                            ),
                            
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black54,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: _isLogin
                                  ? Text(
                                      "Sign In",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  : Text(
                                      "Register",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(20),
                    // login/rtegister
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isLogin
                            ? Text(
                                "Don't have an Account ? ",
                                style: GoogleFonts.poppins(fontSize: 15),
                              )
                            : Text(
                                "Already Have an Account! ",
                                style: GoogleFonts.poppins(fontSize: 15),
                              ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(
                            !_isLogin ? "Login" : "Register",
                            style: GoogleFonts.poppins(
                                fontSize: 15, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
