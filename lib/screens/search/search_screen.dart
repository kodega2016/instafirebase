import 'package:firebaseinsta/screens/profile/profile_screen.dart';
import 'package:firebaseinsta/screens/profile/widgets/user_profile_image.dart';
import 'package:firebaseinsta/screens/search/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _queryController,
          onChanged: (val) {
            if (val.isNotEmpty) {
              context.read<SearchCubit>().searchUsers(val);
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search Users',
            prefixIcon: const Icon(Icons.search_outlined),
            suffixIcon: IconButton(
              onPressed: () {
                _queryController.clear();
                context.read<SearchCubit>().clearSearch();
              },
              icon: const Icon(Icons.clear),
            ),
          ),
        ),
      ),
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == SearchStatus.submitting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == SearchStatus.success) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user.username),
                  subtitle: Text(user.email),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ProfileScreen.routeName,
                      arguments: ProfileScreenArgs(userID: user.id),
                    );
                  },
                  leading: UserProfileImage(
                    radius: 20,
                    profileImageUrl: user.profileImageUrl,
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('Search'),
          );
        },
      ),
    );
  }
}
