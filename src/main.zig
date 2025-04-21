const uefi = @import("std").os.uefi;
const unicode = @import("std").unicode;

fn console_out(con: *uefi.protocol.SimpleTextOutput, msg: [*:0]const u16) !void {
    _ = con.outputString(msg) catch |err| {
        return err;
    };
}

// pub export fn efi_main(handle: uefi.Handle, system_table: *uefi.tables.SystemTable) callconv(.C) uefi.Status {
pub export fn main() callconv(.C) uefi.Status {
    const con_out = uefi.system_table.con_out.?;
    const boot_serv = uefi.system_table.boot_services.?;
    const message = unicode.utf8ToUtf16LeStringLiteral("Hello from Zig!\r\n");

    _ = con_out.reset(false) catch |err| {
        return uefi.Status.fromError(@errorCast(err));
    };

    _ = console_out(con_out, @ptrCast(message)) catch |err| {
        return uefi.Status.fromError(@errorCast(err));
    };

    _ = console_out(con_out, uefi.system_table.firmware_vendor) catch |err| {
        return uefi.Status.fromError(@errorCast(err));
    };

    const status = boot_serv.stall(5 * 1000 * 1000);
    if (status != .success) {
        return status;
    }

    return uefi.Status.success;
}
