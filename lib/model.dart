
class RecipeModel{
  String applabel;
  String appimgUrl;
  double appcalories;
  String appurl;

  RecipeModel({
      this.applabel = "Label",
      this.appimgUrl =  "Image",
      this.appcalories = 0.000,
      this.appurl = "Url",
});

  factory RecipeModel.fromMap(Map recipe)
  {
    return RecipeModel(
      applabel: recipe["label"],
      appcalories: recipe["calories"],
      appimgUrl: recipe["image"],
      appurl: recipe["url"],
    );
  }

}