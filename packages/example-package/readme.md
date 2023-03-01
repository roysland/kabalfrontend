# Publishing a package to Azure Artifacts
A stream must be set up in Azure Devops. Check the STOP Card projects artifacts to see example.

Add a .npmrc file in the package root, same place as where the package.json is.
Add the following to .npmrc
```
registry=https://pkgs.dev.azure.com/kabal-no/c084abf0-7a45-4a87-b5fc-f77fdf5d2d06/_packaging/kabal-npm/npm/registry/ 
                        
always-auth=true
```

Install the VSTS-npm auth globally:
```
npm install -g vsts-npm-auth --registry https://registry.npmjs.com --always-auth false
vsts-npm-auth -config .npmrc
```

## Good Habits
A good habit is to name the packages with an organization prefix. As seen in this example, the package is scoped to @kabal, so the name in the package.json is called @kabal/example-package

