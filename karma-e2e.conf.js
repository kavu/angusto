basePath = '';

frameworks = ['ng-scenario'];

files = [
  'test/e2e/**/*.js'
];
exclude = [];

reporters = ['progress'];

hostname = '0.0.0.0';
port = 8080;
runnerPort = 9100;

colors = true;

// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;

browsers = ['Chrome', 'PhantomJS'];
captureTimeout = 5000;

autoWatch = false;
singleRun = false;

plugins = [
  'karma-ng-scenario',
  'karma-chrome-launcher',
  'karma-phantomjs-launcher'
];
