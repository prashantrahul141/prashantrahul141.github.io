### My personal portfolio site
visit : [prashantrahul.com](https://prashantrahul.com)

This uses [Zola](https://github.com/getzola/zola) to generate a static site hosted on github pages. The theme is a modified version of [Apollo](https://github.com/not-matthias/apollo) theme.

### Building
If you're on nix run
```
nix develop
```

otherwise, idk look in [this file](https://github.com/prashantrahul141/prashantrahul141.github.io/blob/main/flake.nix#L27) and figure out the depencies for your distro and/or os.

create a `.env` file in root directory with the following content:
```.env
GRAPHQL_GITHUB_TOKEN=github_token
```

then run
```sh
# to start serving locally
make serve

# generate final build
make build
```
