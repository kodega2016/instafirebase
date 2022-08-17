// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebaseinsta/screens/create_post/cubit/create_post_cubit.dart';
import 'package:firebaseinsta/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({Key? key}) : super(key: key);

  static const String routeName = '/create-post';

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Create Post',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<CreatePostCubit, CreatePostState>(
        listener: (context, state) {
          if (state.status == CreatePostStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure!.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.status == CreatePostStatus.success) {
            _key.currentState?.reset();
            context.read<CreatePostCubit>().reset();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Post created successfully.'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    context
                        .read<CreatePostCubit>()
                        .onChangeFile(File(image.path));
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  color: Colors.grey[200],
                  width: double.infinity,
                  child: state.postImage == null
                      ? Icon(Icons.image, size: 120, color: Colors.grey[400])
                      : Image.file(state.postImage!),
                ),
              ),
              Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged:
                            context.read<CreatePostCubit>().onChangeCaption,
                        decoration:
                            const InputDecoration(labelText: 'Caption...'),
                      ),
                      const SizedBox(height: 20),
                      PElevatedButton(
                        isBusy: state.status == CreatePostStatus.submitting,
                        onPressed: () async {
                          _key.currentState?.validate();
                          await context.read<CreatePostCubit>().submit();
                        },
                        label: 'Post',
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
