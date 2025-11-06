import 'package:talabajon/data/models/user/update_profile_model.dart';

sealed class ProfileEvent {}

final class UpdateProfileEvent extends ProfileEvent {
  final UpdateProfileModel profile;

  UpdateProfileEvent({required this.profile});
}
