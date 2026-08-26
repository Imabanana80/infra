{
    excludes = [
      ".cache"
      "*/cache2"
      "*/Cache"
      ".config/Slack/logs"
      ".config/Code/CachedData"
      ".container-diff"
      ".npm/_cacache"
      "*/node_modules"
      "*/bower_components"
      "*/_build"
      "*/.tox"
      "*/venv"
      "*/.venv"
      ".local/share/Steam"
    ];

    mapExcludes = paths: map(x: paths + "/" + x) (import ./exclude.nix).excludes;
}
