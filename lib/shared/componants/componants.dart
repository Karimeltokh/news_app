import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';


Widget defaultButton({
  double width,
  Color background,
  bool isUpperCase =true,
  @required Function function,
  @required String text,
})=>Container(
  width: width,
  color: background,
  child: MaterialButton(
    onPressed:function,
    child: Text(
      isUpperCase ?  text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);
Widget defaultTextFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  bool isPassword=false,
  Function onSubmit,
  Function onChanged,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixpressed,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: false,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  validator: validate,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixpressed,
      icon: Icon(
        suffix,
      ),
    ): null,
    border: OutlineInputBorder(),
  ),
);
Widget myDivider()=>Padding(
  padding : const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article,context)=> InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width:  120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list,context,{isSearch=false})=>ConditionalBuilder(
  condition: list.length>0,
  builder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index)=>buildArticleItem(list[index],context),
    separatorBuilder: (context,index)=> myDivider(),
    itemCount: 20,),
  fallback: (context)=> isSearch ? Container() : Center(child: CircularProgressIndicator()),
);

void navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=>widget)
);