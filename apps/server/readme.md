# Server
This is the the served frontend for end-users.
Frontend is bundled in their own folders, and the build output is then copied over here. 

The parts needs to be configured using the middleware strategy.
```
import { handler as marineHandler } from './marine/server/entry.mjs';
app.use(express.static('./marine/dist/client/'))
app.use('/marine', marineHandler);
```

Note that any Astro plugin that is used in the frontend builds, needs to be added to the server as well, since the server runs in standalone mode when deployed.

## Considerations for expanding codebase.
The server is a combination of both frontend and backend. It serves the actual frontend, but also maps REST-API routes. 

The REST API is used when client side modules need to communicate with the server. Since it exposes data from the database, it needs to implement a strict CORS and authentication regime. 
This could be implemented by setting up a JWT middleware that validates the token before all requests. The secret key should be set as an environment/application variable, and should be rotated every now and then. 

