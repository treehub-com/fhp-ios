var fs = require('fs');

var colors = {
  "fhp": "#000000",
  "census": "#008040",
  "country": "#FF0000"
};
var final = {
  categories: []
};

// Directories
for (var dir of ['local', 'learn']) {
  var learn = require('./' + dir + '/learn.json');

  // Categories
  for (var categoryIdx in learn.categories) {
    var categoryPath = learn.categories[categoryIdx];
    var category = require('./' + dir + '/' + categoryPath + '/category.json');
    var color = colors[categoryPath];
    if (!color) {
      console.error('Unknown color for category');
      process.exit(1);
    }
    category.color = color;

    // Modules
    for (var moduleIdx in category.modules) {
      var modulePath = category.modules[moduleIdx];
      var module = require('./' + dir + '/' + categoryPath + '/' + modulePath + '/module.json');
      module.color = color;

      // Lessons
      for (var lessonIdx in module.lessons) {
        var lessonPath = module.lessons[lessonIdx];
        var lesson = require('./' + dir + '/' + categoryPath + '/' + modulePath + '/' + lessonPath + '/lesson.json');
        lesson.color = color;

        // Sections
        for (var sectionIdx in lesson.sections) {
          var sectionPath = lesson.sections[sectionIdx];
          var section = require('./' + dir + '/' + categoryPath + '/' + modulePath + '/' + lessonPath + '/section/' + sectionPath + '.json');

          lesson.sections[sectionIdx] = section;
        }

        module.lessons[lessonIdx] = lesson;
      }

      category.modules[moduleIdx] = module;
    }

    learn.categories[categoryIdx] = category;
  }
  final.categories.push.apply(final.categories, learn.categories);
}
fs.writeFileSync('learn.json', JSON.stringify(final));