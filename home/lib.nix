config: {
    dots = "${config.home.homeDirectory}/infra/config";
    symlink = path: config.lib.file.mkOutOfStoreSymlink path;
}
