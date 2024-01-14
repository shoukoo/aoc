const std = @import("std");

test "solution 1" {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    const file_size = try file.getEndPos();
    const allocator = std.heap.page_allocator;
    const file_buffer = try allocator.alloc(u8, file_size);
    defer allocator.free(file_buffer);

    _ = try file.readAll(file_buffer);

    var i = std.mem.splitAny(u8, file_buffer, "\n");
    // var total: u16 = 0;

    while (i.next()) |line| {
        std.debug.print("line {s}\n", .{line});
        if (std.mem.indexOf(u8, line, ":")) |value| {
            std.debug.print("{s}\n", .{line[0..value]});
            // value + 2 is to skip the colon and a space
            std.debug.print("{s:*^100}\n", .{line[value + 2 ..]});
            break;
        }
    }
}
