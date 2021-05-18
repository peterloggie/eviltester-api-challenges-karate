# The Evil Tester API Challenges - using the Karate framework

I'm a supporter of Alan Richardson and the work he does over at [eviltester.com](eviltester.com). He's created a lot of resources for learning and practising test automation. One of the things he's done is a suite of "API Challenges". The challenges can all be found [here](https://apichallenges.herokuapp.com/gui/challenges)

Alan has a collection of videos where he shows the solutions using Insomnia, an application for (primarily manual) API testing. I wanted to build on this and put together a collection of automated tests to answer the challenges. This particular suite of tests runs using the Karate framework.

## Getting started with Karate

Karate has different modes of operation. We're going to use it in its "simplest" mode - as a single executable JAR file. You can use jbang to run the jar - so you don't even need to worry about installing Java to use Karate this way.

### Installing and running on Mac OS X:

1. Install jbang: `curl -Ls https://sh.jbang.dev | bash -s - app setup`
1. Use jbang to install karate: `bang karate@intuit/karate -h`

#### Running the tests when files change

I wanted to re-run the tests automatically with every change I made. So I set up an [fswatch](https://github.com/emcrisostomo/fswatch) routine.
- `brew install fswatch`

Using the following command, the tests will be run every time a file gets changed. This speeds things up significantly - you don't have to run the test command manually every time you make a change:

- `fswatch ./**/*.* -o --event PlatformSpecific | xargs -n1 jbang karate@intuit/karate *.feature`

Of course, you can choose to run specific files only. When developing tests, I normally watch all files for changes, then only run the feature file I'm working on when a change is made.

## Folder structure

The folder structure is quite simple. In the root, we just have this README and the .gitignore file. We're ignoring the `/target` folder that gets created when you run the tests - this folder stores test reports and logs. You wouldn't normally want these artifacts kept under version control.

- `/features`: this is where we store all of the test scripts (feature files)
- `/features/shared`: the feature files in this folder aren't actually tests (hence why the features have the `@ignore` tag applied - they aren't run by themselves). These features contain common routines that can be called by other feature files. We use one such feature to set headers using common code, rather than repeating this code in every feature file that requires the functionality.
- `/helpers`: there are occasions when you might need to rely on regular code to achieve things. The `helpers` folder contains Javascript functions that our test scripts can call. For example, we have a Javascript function defined that creates the encoded string required for basic authentication.