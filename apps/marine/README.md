# Example frontend part
This is an empty Astro build. The only changes are that the build is set to node-middleware target.
The build scripts copies the build output to the server folder. 

It might be worth considering to deploy the frontend build as an NPM package, and update the servers frontend version that way. 

Note that any Astro plugin that is used in the frontend builds, needs to be added to the server as well, since the server runs in standalone mode when deployed.