var fs = require('fs');

var learn = require('./learn/learn.json');

// Categories
for (var categoryIdx in learn.categories) {
  var categoryPath = learn.categories[categoryIdx];
  var category = require('./learn/' + categoryPath + '/category.json');

  // Modules
  for (var moduleIdx in category.modules) {
    var modulePath = category.modules[moduleIdx];
    var module = require('./learn/' + categoryPath + '/' + modulePath + '/module.json');

    // Lessons
    for (var lessonIdx in module.lessons) {
      var lessonPath = module.lessons[lessonIdx];
      var lesson = require('./learn/' + categoryPath + '/' + modulePath + '/' + lessonPath + '/lesson.json');

      // Sections
      for (var sectionIdx in lesson.sections) {
        var sectionPath = lesson.sections[sectionIdx];
        var section = require('./learn/' + categoryPath + '/' + modulePath + '/' + lessonPath + '/section/' + sectionPath + '.json');

        lesson.sections[sectionIdx] = section;
      }

      module.lessons[lessonIdx] = lesson;
    }

    category.modules[moduleIdx] = module;
  }

  learn.categories[categoryIdx] = category;
}

fs.writeFileSync('learn.json', JSON.stringify(learn));