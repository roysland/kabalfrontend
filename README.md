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

## Build