# Angusto

There are many AngularJS Project Templates, but this one is mine.

## What's inside?

* [Grunt](http://gruntjs.com) — for rapid developing and building project
* [Bower](http://bower.io) — for managing project assets dependencies
* [Yeoman](http://yeoman.io‎) with [generator-angular](https://github.com/yeoman/generator-angular) — for generating AngularJS controllers, services, directives, etc.
* [Karma](http://karma-runner.github.io) — test-runner for CI executing of specs
* [AngularJS](http://angularjs.org) — JS framework itself
* [Twitter Bootstrap](http://twitter.github.io/bootstrap) — famous CSS framework, [Compass SCSS version](https://github.com/vwall/compass-twitter-bootstrap) 

## Installation and Usage

First of all just clone this repo and then:

```
npm install && bower install
```

Now you can…

Start development server:

```
grunt server
```

Single-run tests:

```
grunt test
```

Run Karma in CI mode:

```
karma start karma.conf.js
```

Build project into the `dist/`:

```
grunt build
```

## One more thing

I know that template is clunky and weird (Bootstrap assets requirement and copying them), and I hope I'll find an elegant solution someday. But if you want to suggest some — feel free to open a Pull&nbsp;Request.
