// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebaseinsta/models/user_model.dart';
import 'package:firebaseinsta/repositories/storage/storage_repository.dart';
import 'package:firebaseinsta/repositories/user/user_repository.dart';
import 'package:firebaseinsta/screens/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:firebaseinsta/screens/profile/bloc/profile_bloc.dart';
import 'package:firebaseinsta/screens/profile/widgets/widgets.dart';
import 'package:firebaseinsta/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreenArgs {
  final BuildContext context;

  EditProfileScreenArgs({required this.context});
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  static const String routeName = 'edit-profile';

  static Route route(EditProfileScreenArgs editProfileScreenArgs) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<EditProfileCubit>(
        create: (context) => EditProfileCubit(
          profileBloc: editProfileScreenArgs.context.read<ProfileBloc>(),
          storageRepository: context.read<StorageRepository>(),
          userRepository: context.read<UserRepository>(),
        ),
        child: EditProfileScreen(
          user: editProfileScreenArgs.context.read<ProfileBloc>().state.user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocConsumer<EditProfileCubit, EditProfileState>(
          listenWhen: ((previous, current) =>
              current.status == EditProfileStatus.success),
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
          },
          builder: (context, state) {
            return Column(
              children: [
                UserProfileImage(
                  radius: 50,
                  profileImageUrl: user.profileImageUrl,
                  image: state.file,
                  onPressed: () async {
                    try {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        context
                            .read<EditProfileCubit>()
                            .profileImageChanged(File(image.path));
                      }
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: state.username,
                  enabled: state.status != EditProfileStatus.submitting,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Username'),
                  onChanged: context.read<EditProfileCubit>().nameChanged,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLines: 3,
                  initialValue: state.bio,
                  onChanged: context.read<EditProfileCubit>().bioChanged,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: 'Bio'),
                  enabled: state.status != EditProfileStatus.submitting,
                ),
                const SizedBox(height: 10),
                PElevatedButton(
                  isBusy: state.status == EditProfileStatus.submitting,
                  onPressed: () {
                    context.read<EditProfileCubit>().submit();
                  },
                  label: 'Update',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
