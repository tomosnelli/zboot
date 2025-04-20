const std = @import("std");
const Allocator = std.mem.Allocator;

const targets = [_]std.Target.Query{
    // .{}, // native
    .{
        .cpu_arch = .x86_64,
        .os_tag = .uefi,
    },
    // .{ .cpu_arch = .aarch64, .os_tag = .uefi, .abi = .gnuabi64 },
    // .{ .cpu_arch = .riscv64, .os_tag = .uefi, .abi = .gnuabi64 },
};

pub fn build(b: *std.Build) !void {
    for (targets) |t| {
        // const exe = b.addExecutable(.{
        //     .name = "zboot",
        //     .root_source_file = b.path("src/main.zig"),
        //     .target = b.resolveTargetQuery(t),
        //     .optimize = .ReleaseSafe,
        // });
        const module: *std.Build.Module = b.createModule(.{
            .root_source_file = .{ .src_path = .{ .owner = b, .sub_path = "src/main.zig" } },
            .target = b.resolveTargetQuery(t),
            .optimize = .ReleaseSafe,
            .pic = true,
        });

        const bin: *std.Build.Step.Compile = b.addExecutable(.{
            .name = "zboot",
            .root_module = module,
        });

        bin.entry = .{ .symbol_name = "efi_main" };
        bin.pie = true;
        bin.subsystem = .EfiApplication;
        bin.kind = .exe;

        // const triple: Allocator.Error![]u8 = t.zigTriple(b.allocator) catch @panic("OOM");
        const artifact: *std.Build.Step.InstallArtifact = b.addInstallArtifact(
            bin,
            .{
                .dest_dir = .{
                    .override = .{
                        .custom = try t.zigTriple(b.allocator),
                    },
                },
            },
        );

        b.getInstallStep().dependOn(&artifact.step);
    }
}
