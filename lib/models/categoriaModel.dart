import 'package:json_annotation/json_annotation.dart';

part 'categoriaModel.g.dart';

@JsonSerializable()
class CategoriaModel {
    @JsonKey(name: "id")
    int? id;
    @JsonKey(name: "descripcion")
    String descripcion;

    CategoriaModel({
        this.id,
        required this.descripcion,
    });

    factory CategoriaModel.fromJson(Map<String, dynamic> json) => _$CategoriaModelFromJson(json);

    Map<String, dynamic> toJson() => _$CategoriaModelToJson(this);
}
