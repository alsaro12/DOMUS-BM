import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/pages/blog_page.dart';
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/pages/notificaciones_page.dart';
import 'package:myapp/pages/perfil_page.dart';
import 'package:myapp/pages/propiedades/mis_propiedades_page.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/share_preference/preferencias_usuario.dart';
import 'package:myapp/share_preference/route_transition_do.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class BotomNavBarWidget extends StatelessWidget {
  final int index;
  const BotomNavBarWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle unCheckStyle =
        ThisColors.subtitulo(Colors.grey.shade500, 14, FontWeight.w400);
    TextStyle checkStyle =
        ThisColors.subtitulo(ThisColors.primary, 14, FontWeight.w700);
    double sizeUnCheck = 35;
    double sizeCheck = 45;

    return Container(
      width: double.infinity,
      height: 56,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              RouteTransitionDo(
                  context: context,
                  animationType: AnimationType.fadeIn,
                  child: BlogPage());
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    LineIcons.newspaper,
                    color: (index == 0)
                        ? ThisColors.primary
                        : Colors.grey.shade500,
                    size: (index == 0) ? 35 : 30,
                  ),
                  Text(
                    'Blog',
                    style: (index == 0) ? checkStyle : unCheckStyle,
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              RouteTransitionDo(
                  context: context,
                  animationType: AnimationType.fadeIn,
                  child: MisPropiedadesPage());
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.home_outlined,
                    color: (index == 1)
                        ? ThisColors.primary
                        : Colors.grey.shade500,
                    size: (index == 1) ? 35 : 30,
                  ),
                  Text('Mis Propiedades',
                      style: (index == 1) ? checkStyle : unCheckStyle)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              RouteTransitionDo(
                  context: context,
                  animationType: AnimationType.fadeIn,
                  child: PerfilPage());
            },
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    color: (index == 2)
                        ? ThisColors.primary
                        : Colors.grey.shade500,
                    size: (index == 2) ? 35 : 30,
                  ),
                  Text(
                    'Perfil',
                    style: (index == 2) ? checkStyle : unCheckStyle,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function? onTap;
  final bool? isSelected;
  final Color? iconColor;

  DrawerTile(
      {this.title,
      this.icon,
      this.onTap,
      this.isSelected = false,
      this.iconColor = ArgonColors.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: isSelected! ? ThisColors.primary : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              Icon(icon,
                  size: 20, color: isSelected! ? ThisColors.white : ThisColors.primary),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(title!,
                    style: TextStyle(
                        letterSpacing: .3,
                        fontSize: 15,
                        color: isSelected!
                            ? ArgonColors.white
                            : ThisColors.primary)),
              )
            ],
          )),
    );
  }
}

class ArgonDrawer extends StatefulWidget {
  @override
  State<ArgonDrawer> createState() => _ArgonDrawerState();
}

class _ArgonDrawerState extends State<ArgonDrawer> {
  @override
  Widget build(BuildContext context) {
    var usuarioP = Provider.of<UsuarioProvider>(context, listen: false);
    var pref = PreferenciasUsuario();
    return Drawer(
        child: Container(
      color: Colors.white,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 55.0),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.85,
              child: SafeArea(
                bottom: false,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 32,
                    ),
                    child: SizedBox(
                      width: 230,
                      height: 220,
                      child: Transform.scale(
                        scale: 2,
                        child: Image.asset('assets/img4.png',
                            fit: BoxFit.fitHeight),
                      ),
                    ),
                  ),
                ),
              )),
        ),
        Consumer<NavBarProvider>(
          builder: (BuildContext context, nabBarP, Widget? child) => Expanded(
            flex: 8,
            child: ListView(
              padding: EdgeInsets.only(top: 70, left: 16, right: 16),
              children: [
                const Divider(
                    height: 4, thickness: 0, color: ArgonColors.muted),
                DrawerTile(
                    icon: LineIcons.blog,
                    onTap: () {
                      nabBarP.index = 0;
                      RouteTransitionDo(
                          context: context,
                          animationType: AnimationType.fadeIn,
                          child: BlogPage());
                    },
                    iconColor: ThisColors.primary,
                    title: "Blog",
                    isSelected: nabBarP.index == 0 ? true : false),
                DrawerTile(
                    icon: Icons.account_circle,
                    onTap: () {
                      nabBarP.index = 1;
                      RouteTransitionDo(
                          context: context,
                          animationType: AnimationType.fadeIn,
                          child: PerfilPage());
                    },
                    iconColor: ArgonColors.warning,
                    title: "Perfil",
                    isSelected: nabBarP.index == 1 ? true : false),
                DrawerTile(
                    icon: Icons.business_outlined,
                    onTap: () async {
                      nabBarP.index = 2;
                      RouteTransitionDo(
                        context: context,
                        animationType: AnimationType.fadeIn,
                        child: MisPropiedadesPage(),
                      );
                    },
                    iconColor: ArgonColors.info,
                    title: "Mis propiedades",
                    isSelected: nabBarP.index == 2 ? true : false),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                      height: 4, thickness: 0, color: ArgonColors.muted),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0, left: 16, bottom: 0),
                    child: Text("Otros",
                        style: TextStyle(
                          color: ThisColors.primary,
                          fontSize: 15,
                        )),
                  ),
                  DrawerTile(
                      icon: Icons.info_outline,
                      onTap: () {},
                      iconColor: ArgonColors.muted,
                      title: "Términos y condiciones",
                      isSelected: false),
                  Consumer<NavBarProvider>(
                    builder: (BuildContext context, navBarP, Widget? child) =>
                        DrawerTile(
                            icon: Icons.logout,
                            onTap: () {
                              PreferenciasUsuario pref = PreferenciasUsuario();
                              pref.access_token = '';
                              RouteTransitionDo(
                                  context: context,
                                  animationType: AnimationType.fadeIn,
                                  child: LoginPage());
                            },
                            iconColor: ArgonColors.muted,
                            title: "Cerrar Sesión",
                            isSelected: false),
                  ),
                ],
              )),
        ),
      ]),
    ));
  }
}

class Input extends StatelessWidget {
  final String? placeholder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function? onTap;
  final Function? onChanged;
  final TextEditingController? controller;
  final bool? autofocus;
  final Color? borderColor;

  Input(
      {this.placeholder,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.onChanged,
      this.autofocus = false,
      this.borderColor = ArgonColors.border,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: ArgonColors.muted,
        onTap: () => onTap,
        onChanged: (String value) => onChanged,
        controller: controller,
        autofocus: autofocus!,
        style:
            TextStyle(height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
        textAlignVertical: TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
            filled: true,
            fillColor: ArgonColors.white,
            hintStyle: TextStyle(
              color: ArgonColors.muted,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor!, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor!, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final String? categoryOne;
  final String? categoryTwo;
  final bool? searchBar;
  final bool? backButton;
  final bool? transparent;
  final bool? rightOptions;
  final List<String>? tags;
  final Function? getCurrentPage;
  final bool? isOnSearch;
  final TextEditingController? searchController;
  final Function? searchOnChanged;
  final bool? searchAutofocus;
  final bool? noShadow;
  final Color? bgColor;

  Navbar(
      {this.title = "Home",
      this.categoryOne = "",
      this.categoryTwo = "",
      this.tags,
      this.transparent = false,
      this.rightOptions = true,
      this.getCurrentPage,
      this.searchController,
      this.isOnSearch = false,
      this.searchOnChanged,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = false,
      this.bgColor = ArgonColors.white,
      this.searchBar = false});

  final double _prefferedHeight = 180.0;

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> {
  late String activeTag;

  ItemScrollController _scrollController = ItemScrollController();

  void initState() {
    if (widget.tags != null && widget.tags?.length != 0) {
      activeTag = widget.tags![0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne!.isNotEmpty && widget.categoryTwo!.isNotEmpty;
    final bool tagsExist =
        widget.tags == null ? false : (widget.tags!.length == 0 ? false : true);

    return Container(
        height: widget.searchBar!
            ? (!categories
                ? (tagsExist ? 214.0 : 182.0)
                : (tagsExist ? 265.0 : 213.0))
            : (!categories
                ? (tagsExist ? 165.0 : 105.0)
                : (tagsExist ? 203.0 : 153.0)),
        decoration: BoxDecoration(
            color: !widget.transparent! ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent! && !widget.noShadow!
                      ? ArgonColors.initial
                      : Colors.transparent,
                  spreadRadius: -10,
                  blurRadius: 12,
                  offset: Offset(0, 5))
            ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                                !widget.backButton!
                                    ? Icons.menu
                                    : Icons.arrow_back_ios,
                                color: !widget.transparent!
                                    ? (widget.bgColor == ArgonColors.white
                                        ? ArgonColors.initial
                                        : ArgonColors.white)
                                    : ArgonColors.white,
                                size: 24.0),
                            onPressed: () {
                              if (!widget.backButton!)
                                Scaffold.of(context).openDrawer();
                              else
                                Navigator.pop(context);
                            }),
                        Text(widget.title!,
                            style: TextStyle(
                                color: !widget.transparent!
                                    ? (widget.bgColor == ArgonColors.white
                                        ? ArgonColors.initial
                                        : ArgonColors.white)
                                    : ArgonColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0)),
                      ],
                    ),
                    if (widget.rightOptions!)
                      Consumer<NotificacionesProvider>(
                        builder: (BuildContext context, notificacionesP,
                                Widget? child) =>
                            Container(
                          width: 40,
                          height: 35,
                          child: GestureDetector(
                            onTap: () {
                              RouteTransitionDo(
                                  context: context,
                                  animationType: AnimationType.fadeIn,
                                  child: NotificacionesPage());
                            },
                            child: Stack(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.notifications_active,
                                        color: !widget.transparent!
                                            ? (widget.bgColor ==
                                                    ArgonColors.white
                                                ? ArgonColors.initial
                                                : ArgonColors.white)
                                            : ArgonColors.white,
                                        size: 25.0),
                                    onPressed: null),
                                (notificacionesP.cantNotSinLeer != 0)
                                    ? Positioned(
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              notificacionesP.cantNotSinLeer
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
                if (widget.searchBar!)
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 4, left: 15, right: 15),
                    child: Input(
                        placeholder: "What are you looking for?",
                        controller: widget.searchController,
                        onChanged: widget.searchOnChanged,
                        autofocus: widget.searchAutofocus,
                        suffixIcon:
                            Icon(Icons.zoom_in, color: ArgonColors.muted),
                        onTap: () {
                          Navigator.pushNamed(context, '/pro');
                        }),
                  ),
                SizedBox(
                  height: 10.0,
                ),
                if (categories)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/pro');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.camera,
                                color: ArgonColors.initial, size: 22.0),
                            SizedBox(width: 10),
                            Text(widget.categoryOne!,
                                style: TextStyle(
                                    color: ArgonColors.initial,
                                    fontSize: 16.0)),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      Container(
                        color: ArgonColors.initial,
                        height: 25,
                        width: 1,
                      ),
                      SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/pro');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.shopping_cart,
                                color: ArgonColors.initial, size: 22.0),
                            SizedBox(width: 10),
                            Text(widget.categoryTwo!,
                                style: TextStyle(
                                    color: ArgonColors.initial,
                                    fontSize: 16.0)),
                          ],
                        ),
                      )
                    ],
                  ),
                if (tagsExist)
                  Container(
                    height: 40,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.tags!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (activeTag != widget.tags![index]) {
                              setState(() => activeTag = widget.tags![index]);
                              _scrollController.scrollTo(
                                  index:
                                      index == widget.tags!.length - 1 ? 1 : 0,
                                  duration: Duration(milliseconds: 420),
                                  curve: Curves.easeIn);
                              if (widget.getCurrentPage != null)
                                widget.getCurrentPage!(activeTag);
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 46 : 8, right: 8),
                              padding: EdgeInsets.only(
                                  top: 4, bottom: 4, left: 20, right: 20),
                              // width: 90,
                              decoration: BoxDecoration(
                                  color: activeTag == widget.tags![index]
                                      ? ArgonColors.primary
                                      : ArgonColors.secondary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0))),
                              child: Center(
                                child: Text(widget.tags![index],
                                    style: TextStyle(
                                        color: activeTag == widget.tags![index]
                                            ? ArgonColors.white
                                            : ArgonColors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0)),
                              )),
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
        ));
  }
}

class TableCellSettings extends StatelessWidget {
  final String? title;
  final Function? onTap;
  TableCellSettings({this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title!, style: TextStyle(color: ArgonColors.text)),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_forward_ios,
                  color: ArgonColors.text, size: 14),
            )
          ],
        ),
      ),
    );
  }
}
