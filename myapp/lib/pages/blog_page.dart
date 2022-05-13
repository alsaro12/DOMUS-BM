import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:myapp/Theme.dart';
import 'package:myapp/providers.dart';
import 'package:myapp/widgets.dart';
import 'package:provider/provider.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

class BlogPage extends StatefulWidget {
  BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    var blogP =
        Provider.of<BlogProvider>(context, listen: false);
    return Scaffold(
      drawer: ArgonDrawer(),
      appBar: Navbar(
        title: "Blog",
        bgColor: ThisColors.label,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: blogP.cargarPublicaciones(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Blog>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: blogP.listPublicaciones.length,
                        itemBuilder: (BuildContext context, int index) {
                          Blog publicacion = Blog();
                          publicacion = blogP.listPublicaciones
                              .elementAt(index);
                          String htmlData = publicacion.body_publication;
                          dom.Document document = htmlparser.parse(htmlData);
                          String _html = '''
                          <p><span style="color:#2980b9"><strong>Se le comunica a todos los residentes que:</strong></span></p><ul><li>El d&iacute;a de ma&ntilde;ana se subir&aacute; a producci&oacute;n la nueva plataforma web de residentes</li><li>El acceso a sus cuentas tendr&aacute; una variaci&oacute;n en recepcionar c&oacute;digos captcha como validaci&oacute;n.</li></ul><p>Atentamente,</p><p><strong>ADMINISTRACI&Oacute;N.</strong></p>
                          ''';
                          String html2 = htmlData;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.5),
                            child: Column(
                              children: [
                                Container(
                                  height: 25,
                                  color: ThisColors.label,
                                  child: Center(
                                    child: Text(
                                      '${publicacion.name_building}',
                                      style: ThisColors.titulo(ThisColors.white,
                                          15, FontWeight.bold),
                                    ),
                                  ),
                                ),
                                (publicacion.url_image_publication.isNotEmpty)
                                    ? Container(
                                        width: double.infinity,
                                        height: 120,
                                        child: Image.network(
                                          publicacion.url_image_publication,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      )
                                    : Container(),
                                Gap(10),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                      '${publicacion.head_publication}',
                                      style: ThisColors.titulo(
                                          Color.fromARGB(255, 26, 26, 26),
                                          20,
                                          FontWeight.bold)),
                                ),
                                Gap(10),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                      '${publicacion.publication_date.substring(1, 17)} Hrs',
                                      // 'PENDIENTE',
                                      style: ThisColors.subtitulo(
                                          Color.fromARGB(255, 89, 88, 88),
                                          14,
                                          FontWeight.normal)),
                                ),
                                Gap(10),
                                GestureDetector(
                                  onTap: () {
                                  },
                                  child: Container(
                                    height: 200,
                                    child: HtmlWidget(
                                      html2,
                                    ),
                                  ),
                                ),
                                Gap(20),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
