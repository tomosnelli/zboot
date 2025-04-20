const uefi = @import("std").os.uefi;
const unicode = @import("std").unicode;

// pub export fn efi_main(handle: uefi.Handle, system_table: *uefi.tables.SystemTable) callconv(.C) uefi.Status {
pub export fn main() callconv(.C) uefi.Status {
    // _ = handle;

    const con_out = uefi.system_table.con_out.?;
    const boot_serv = uefi.system_table.boot_services.?;
    const message = unicode.utf8ToUtf16LeStringLiteral("Hello from Zig!\r\n");

    con_out.reset(false) catch |err| {
        // issue
        switch (err) {
            error.Unexpected => return uefi.Status.aborted,
            error.DeviceError => return uefi.Status.device_error,
            else => unreachable,
        }
    };

    // _ = con_out.outputString(&[_:0]u16{ 'H', 'e', 'l', 'l', 'o', ' ', 'f', 'r', 'o', 'm', ' ', 'z', 'i', 'g', '!', '\n', 0 }) catch |err| {
    _ = con_out.outputString(@ptrCast(message)) catch |err| {
        // issue
        switch (err) {
            error.Unexpected => return uefi.Status.aborted,
            error.DeviceError => return uefi.Status.device_error,
            else => unreachable,
        }
    };

    _ = con_out.outputString(@ptrCast(uefi.system_table.firmware_vendor)) catch |err| {
        // issue
        switch (err) {
            error.Unexpected => return uefi.Status.aborted,
            error.DeviceError => return uefi.Status.device_error,
            else => unreachable,
        }
    };

    const status = boot_serv.stall(5 * 1000 * 1000);
    if (status != uefi.Status.success) {
        _ = con_out.outputString(&[_:0]u16{ 'E', 'r', 'r', 'o', 'r', '!', '\n', 0 }) catch |err| {
            switch (err) {
                error.Unexpected => return uefi.Status.aborted,
                error.DeviceError => return uefi.Status.device_error,
                else => unreachable,
            }
        };
    }

    return uefi.Status.success;
}
