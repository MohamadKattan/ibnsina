import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CreateNewAccount extends AuthEvent{}


class SignInByAccount extends AuthEvent{}

class GetDataFromAuth extends AuthEvent{}