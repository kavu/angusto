basePath = '';

frameworks = ['jasmine'];

files = [
  'app/components/angular/angular.js',
  'app/components/angular-mocks/angular-mocks.js',
  'app/scripts/**/*.js',
  'test/mock/**/*.js',
  'test/spec/**/*.js'
];
exclude = [];

preprocessors = {
  'app/scripts/**/*.js': 'coverage'
};

reporters = ['progress', 'coverage'];

coverageReporter = {
  type : 'html',
  dir : 'coverage/'
}

hostname = '0.0.0.0';
port = 8080;
runnerPort = 9100;

colors = true;

// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_ERROR;

browsers = ['Chrome', 'PhantomJS'];
captureTimeout = 5000;

autoWatch = true;
singleRun = false;

plugins = [
  'karma-jasmine',
  'karma-coverage',
  'karma-chrome-launcher',
  'karma-phantomjs-launcher'
];
