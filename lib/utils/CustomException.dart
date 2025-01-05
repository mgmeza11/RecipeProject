class CustomException implements Exception{
  final String message;
  CustomException(this.message);

  @override
  String toString() {
    return message;
  }
}

enum CustomExceptionTypes{
  empty('Aún no cuentas con recetas'),
  notFound('No se han encontrado resultados'),
  technicalError('Ha ocurrido un error técnico'),
  noResult('No se han encontrado resultados que coincidan con el criterio de búsqueda');

  final String message;
  const CustomExceptionTypes(this.message);
}