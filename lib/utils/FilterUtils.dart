import '../models/Tag.dart';
import 'Categories.dart';

String getFilterLabel(dynamic item){
if(item is CategoryType) return item.name;
if(item is Tag) return item.description;
return "";
}