'use strict';
var Generator = require('yeoman-generator');
var fs = require('fs');
var path = require('path');

module.exports = Generator.extend({
  prompting: function () {
    var prompts = [{
      type: 'input',
      name: 'language',
      message: 'What language or environment is this IDE for?'
    }, {
      type: 'input',
      name: 'baseImage',
      message: 'What Docker baseImage should we use?'
    }];

    return this.prompt(prompts).then(function (props) {
      this.props = props;
    }.bind(this));
  },

  writing: function () {
    var self = this;

    fs.readdir(this.templatePath(), function (err, files) {
      if (err) {
        throw err;
      }

      files.forEach(function (file) {
        self.fs.copyTpl(
          self.templatePath(file),
          self.destinationPath(path.join(self.props.language, file)),
          self.props
        );
      });
    });
  }

});
