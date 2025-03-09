### My personal portfolio site
visit : [prashantrahul.com](https://prashantrahul.com)

This uses [Zola](https://github.com/getzola/zola) to generate a static site hosted on github pages. The theme is a modified version of [Apollo](https://github.com/not-matthias/apollo) theme.

### Building
If you're on nix run
```
nix develop
```

otherwise install the following requirements manually:
- [Zola](https://github.com/getzola/zola)
- [gnumake](https://www.gnu.org/software/make/)

create a `.env` file in root directory with the following content:
```.env
GITHUB_TOKEN=github_token
```

then run
```sh
# to start serving locally
make serve

# generate final build
make build
```
