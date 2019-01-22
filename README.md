# git-statr
Git statistics toolbox

This is a BIG hack. Nothing but a hack. Probably breaking at least 3 rules of software development. But it works for what I need it to. 

## Begin
This toolbox contains the following fine tools used for spelunking git statistics. Each has it's own little advantages/insights over the others. Respect the work put into these projects.
* [sloc](https://www.npmjs.com/package/sloc)
* [gitstats](http://gitstats.sourceforge.net/)
* [git-stats](https://github.com/IonicaBizau/git-stats)
* [git-quick-stats](https://github.com/arzzen/git-quick-stats)

## Building and Running
This is how to build the image and an example of running it.

### Build it
1. clone this repository
2. change directory to your clone of the repository
3. Docker build it
```
docker build -t git-statr .
```

### Run it
Once you have the image you can run a container from it. I prefer to pass my ssh keys and existing repository to inspect on launch. This way I can manipulate the git repo within the container easily.
```
$ docker run -i -t -v /Users/tony/.ssh/:/root/.ssh -v /Users/tony/Dev/cool-project/:/cool-project git-statr
```
This will dump you into the running container's shell prompt where you can use the installed tools. Continue reading for example usage.

## How to use the tools
The usages assume you are running in interactive mode and have a git repository within the container. The example from the build and run section shows how to pass a local repository to the container when it is created and using the container in interactive mode.

### Using sloc
1. Change directory to your repository
```
$ cd myrepo
```

2. Run sloc
```
$ sloc
```

### Using gitstats
Git stats will generate the most complete reports (in my opinion). The results report is reported in an HTML format.

1. Change directory to your repository
```
$ cd myrepo
```
2. Run the tool against the current dir and place the output in a folder in the current directory. This example also shows naming the report. See the tool help for more optional config values.
```
$ gitstats -c project_name=<optional name for your report> . ./<outputdir>
```

To get the report from the container to your localhost we need to use docker on cp from a terminal on the localhost. Need to provide the source as a hash of the container and the output location and the destination on the local filesystem
```
$ docker cp 614f7e0e5ccb:/<myrepo>/<outputdir> <destination on localhost>
```
From the results directory you can open index.html in a browser to view results.

### Using git-stats
This one is ok. Not too useful for my needs tho.
1. Change directory to your repository
```
$ cd myrepo
```
2. For a global activity calendar in the current repository
```
$ git-stats -g
```
3. For  a pie chart with the author related contributions in the current repository.
```
$ git-stats -a
```

### Using git-quick-stats
1. Change directory to your repository
```
$ cd myrepo
```
2. Run git-quick-stats
```
$ git-quick-stats
```
3. Follow the interactive prompts
