const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const module = b.createModule(.{
        .root_source_file = b.path("src/hellozig.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    const lib = b.addLibrary(.{
        .linkage = .static,
        .name = "hellozig",
        .root_module = module,
    });
    b.installArtifact(lib);
    b.getInstallStep().dependOn(&b.addInstallHeaderFile(b.path("src/hellozig.h"), "hellozig.h").step);
}
