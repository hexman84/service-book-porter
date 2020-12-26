import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servicebook/bloc/check_users/check_users_bloc.dart';
import 'package:servicebook/bloc/rooms/bloc.dart';
import 'package:servicebook/resources/resources.dart';
import 'package:servicebook/ui/widgets/floor_list_view.dart';
import 'package:servicebook/ui/widgets/logged_user_display_name.dart';
import 'package:servicebook/ui/widgets/logout.dart';
import 'package:servicebook/ui/widgets/screen_buttons.dart';
import 'package:servicebook/ui/widgets/service_book_app_bar.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundScaffold,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ServiceBookLogo(),
                  ScreenButtons(
                    roomsPage: true,
                  ),
                  LoggedUserName(),
                  LogOut(),
                ],
              ),
            ),
            elevation: 0,
            backgroundColor: AppColors.white,
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: BlocListener<CheckUsersBloc, CheckUsersState>(
                listener: (context, errorState) {
                  if (errorState is ShowError) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(errorState.error),
                    ));
                  }
                },
                child: BlocBuilder<RoomsBloc, RoomsState>(
                  builder: (context, state) {
                    if (state is RoomsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is RoomsLoaded) {
                      if (state.rooms.isEmpty) {
                        return Center(
                          child: Text('Данных нет', style: AppTextStyles.regularStyle),
                        );
                      }
                      return Column(
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.rooms.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return FloorListView(rooms: state.rooms[index]);
                            },
                          ),
                        ],
                      );
                    }
                    if (state is RoomsFailure) {
                      return Center(
                        child: Text('Ошибка загрузки данных...', style: AppTextStyles.regularStyle),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
