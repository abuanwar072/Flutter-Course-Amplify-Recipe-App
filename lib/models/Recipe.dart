/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Recipe type in your schema. */
class Recipe extends amplify_core.Model {
  static const classType = const _RecipeModelType();
  final String id;
  final String? _title;
  final int? _serve;
  final Duration? _duration;
  final Category? _category;
  final String? _description;
  final String? _image;
  final int? _duration_unit;
  final List<String>? _ingredients;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  RecipeModelIdentifier get modelIdentifier {
      return RecipeModelIdentifier(
        id: id
      );
  }
  
  String get title {
    try {
      return _title!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get serve {
    try {
      return _serve!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Duration get duration {
    try {
      return _duration!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Category get category {
    try {
      return _category!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get description {
    try {
      return _description!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get image {
    try {
      return _image!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get duration_unit {
    try {
      return _duration_unit!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String> get ingredients {
    try {
      return _ingredients!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Recipe._internal({required this.id, required title, required serve, required duration, required category, required description, required image, required duration_unit, required ingredients, createdAt, updatedAt}): _title = title, _serve = serve, _duration = duration, _category = category, _description = description, _image = image, _duration_unit = duration_unit, _ingredients = ingredients, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Recipe({String? id, required String title, required int serve, required Duration duration, required Category category, required String description, required String image, required int duration_unit, required List<String> ingredients}) {
    return Recipe._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      title: title,
      serve: serve,
      duration: duration,
      category: category,
      description: description,
      image: image,
      duration_unit: duration_unit,
      ingredients: ingredients != null ? List<String>.unmodifiable(ingredients) : ingredients);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Recipe &&
      id == other.id &&
      _title == other._title &&
      _serve == other._serve &&
      _duration == other._duration &&
      _category == other._category &&
      _description == other._description &&
      _image == other._image &&
      _duration_unit == other._duration_unit &&
      DeepCollectionEquality().equals(_ingredients, other._ingredients);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Recipe {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("serve=" + (_serve != null ? _serve!.toString() : "null") + ", ");
    buffer.write("duration=" + (_duration != null ? amplify_core.enumToString(_duration)! : "null") + ", ");
    buffer.write("category=" + (_category != null ? amplify_core.enumToString(_category)! : "null") + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("image=" + "$_image" + ", ");
    buffer.write("duration_unit=" + (_duration_unit != null ? _duration_unit!.toString() : "null") + ", ");
    buffer.write("ingredients=" + (_ingredients != null ? _ingredients!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Recipe copyWith({String? title, int? serve, Duration? duration, Category? category, String? description, String? image, int? duration_unit, List<String>? ingredients}) {
    return Recipe._internal(
      id: id,
      title: title ?? this.title,
      serve: serve ?? this.serve,
      duration: duration ?? this.duration,
      category: category ?? this.category,
      description: description ?? this.description,
      image: image ?? this.image,
      duration_unit: duration_unit ?? this.duration_unit,
      ingredients: ingredients ?? this.ingredients);
  }
  
  Recipe copyWithModelFieldValues({
    ModelFieldValue<String>? title,
    ModelFieldValue<int>? serve,
    ModelFieldValue<Duration>? duration,
    ModelFieldValue<Category>? category,
    ModelFieldValue<String>? description,
    ModelFieldValue<String>? image,
    ModelFieldValue<int>? duration_unit,
    ModelFieldValue<List<String>>? ingredients
  }) {
    return Recipe._internal(
      id: id,
      title: title == null ? this.title : title.value,
      serve: serve == null ? this.serve : serve.value,
      duration: duration == null ? this.duration : duration.value,
      category: category == null ? this.category : category.value,
      description: description == null ? this.description : description.value,
      image: image == null ? this.image : image.value,
      duration_unit: duration_unit == null ? this.duration_unit : duration_unit.value,
      ingredients: ingredients == null ? this.ingredients : ingredients.value
    );
  }
  
  Recipe.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _serve = (json['serve'] as num?)?.toInt(),
      _duration = amplify_core.enumFromString<Duration>(json['duration'], Duration.values),
      _category = amplify_core.enumFromString<Category>(json['category'], Category.values),
      _description = json['description'],
      _image = json['image'],
      _duration_unit = (json['duration_unit'] as num?)?.toInt(),
      _ingredients = json['ingredients']?.cast<String>(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'serve': _serve, 'duration': amplify_core.enumToString(_duration), 'category': amplify_core.enumToString(_category), 'description': _description, 'image': _image, 'duration_unit': _duration_unit, 'ingredients': _ingredients, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'title': _title,
    'serve': _serve,
    'duration': _duration,
    'category': _category,
    'description': _description,
    'image': _image,
    'duration_unit': _duration_unit,
    'ingredients': _ingredients,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<RecipeModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<RecipeModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TITLE = amplify_core.QueryField(fieldName: "title");
  static final SERVE = amplify_core.QueryField(fieldName: "serve");
  static final DURATION = amplify_core.QueryField(fieldName: "duration");
  static final CATEGORY = amplify_core.QueryField(fieldName: "category");
  static final DESCRIPTION = amplify_core.QueryField(fieldName: "description");
  static final IMAGE = amplify_core.QueryField(fieldName: "image");
  static final DURATION_UNIT = amplify_core.QueryField(fieldName: "duration_unit");
  static final INGREDIENTS = amplify_core.QueryField(fieldName: "ingredients");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Recipe";
    modelSchemaDefinition.pluralName = "Recipes";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.TITLE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.SERVE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.DURATION,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.CATEGORY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.DESCRIPTION,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.IMAGE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.DURATION_UNIT,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Recipe.INGREDIENTS,
      isRequired: true,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _RecipeModelType extends amplify_core.ModelType<Recipe> {
  const _RecipeModelType();
  
  @override
  Recipe fromJson(Map<String, dynamic> jsonData) {
    return Recipe.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Recipe';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Recipe] in your schema.
 */
class RecipeModelIdentifier implements amplify_core.ModelIdentifier<Recipe> {
  final String id;

  /** Create an instance of RecipeModelIdentifier using [id] the primary key. */
  const RecipeModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'RecipeModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is RecipeModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}