# Frontend Skeleton Setup

## How it works
This is a monorepo, which contains several packages and applications. This is the general setup.

*/apps folder*
The apps folder include fully working frontend parts and a server.
Each frontend part (ie: marine), should work as a standalone application when running devmode. The server is the part that collects them all into one application.

Each frontend build outputs an Express middleware, which is exported from the package in package.json.

The server then includes the middleware and the static files, and maps them to a route.

*/packages*
Packages are modules that are used in other applications. These include shared libraries like styles and utility packages, but also the interactive parts used in one or many frontend parts.

Packages must be scoped to an organization. This is done by setting the name to @kabal/example-package. To include it in other packages/apps, you import it using:
```
# package.json
"dependencies": {
    "@kabal/example-package": "*"
}

# javascript file
import Example from "@kabal/example-package"
```

## Build

Packages should have their own build step, that publish an NPM package to an artifact store. See *example-package* for example to deploy to Azure Artifacts.

It doesn't really matter which artifact repository you choose, whether it is Azure, AWS, Github or a private NPM registry, the workflow is the same.

For apps, the steps differ. The Astro projects should be set up to build a Nodejs middleware. You need to export the dist folder to include it in the actual node server.

The server is the main component in this monorepo. It imports all Astro frontends and maps them to different routes. Since the dependencies are within this repo, it is necessary to prune the repo before building an image. Pruning takes all dependencies and sorts them out for a production build.

```
turbo prune --scope=\"server\" --docker
```
This creates an out folder, from which the dockerfile builds from.

# Azure setup
* Create a Container registry. Although not stated anywhere, this NEEDS to be a lowercase name, or else github actions will fail.
* Upload container to registry
* Create a Web App with container
* Once the app service is running, go to Deployment > Deployment center
* Change source to Github Actions (or Azure pipelines if you want to use Azure Devops)

# AWS Lightsail Container setup
* Create an Lightsail project. Create a new container service.
* Use the *push:image* command (modify to your own instance)
* Use the *aws_lightsail.yml* workflow for building and deploying the image to Lightsail.

# AWS Lightsail instance
This should only be used for dev environment. It will be faster to deploy to, since it skips building a docker image, but it is a full VPS, so you need to keep the system up to date yourself. You also need to set up endpoints and triggers for Github webhooks so that the repo is kept up to date.

You could potentially spin up multiple branches. You should then change the .env file in *apps/server* to use a different port. And instead of remembering that a certain environment runs on that port, you could set up NGINX reverse proxy to give them more human names (and dynamic routing, if you want to implement PR review apps)

* Since oracle libraries are platform specific, it's advisable to create a OS only image. 
* Set up Nodejs (with nvm), oracle libraries.
* Set up git, and add config
* Install PM2 (node process manager). Optionally install Nginx.
* Set up a webhook-service that handles Github webhooks.

# Advice on infrastructure
* Both AWS and Azure provides easy to set up pipelines for CI/CD, but Github Actions is more cloud agnostic. 
* When setting up microservices, for example a message queue, you can use cloud services or set up your own. Cloud services requires less configuration and have their benefits, but consider just adding a Redis or RabbitMQ instance as a container. You can handle these easily through docker-compose. 

# Advice on javascript code
* Treat imported libraries as immutable.
* When using third party libraries, pure javascript libraries are preferred over framework specific ones.
* Anytime you find yourself writing a *util* function, consider creating a package for it. Then you can reuse it.
* Try to keep functions pure. That means that the function doesn't have to know about the inner workings of the script your writing. 
* Variables and functions should be named according to what they do, without abbreviations. The function calculateAgeFromBirthYear() is easier to read than calcAge(). The only acceptable short variables names are *i* for iterations.
* * *e* is often used for both event and error.
```
// Good
function userClickedButton (event) {}
// Bad
function handleClick (e) {}

// Good
try {}
catch (error) {
    throw new Error(error.message)
}
finally () {
    // This fires every time
    closeDatabaseConnection()
}

// Bad
if (someStatement) {
    dosomething()
} else {
    console.log('error')
}

```
