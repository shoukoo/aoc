const print = @import("std").debug.print;
const split = @import("std").mem.splitAny;
const expect = @import("std").testing.expect;
const input = @import("input.zig");
const std = @import("std");

test "solution 1" {
    var i = split(u8, input.puzzle_input, "\n");
    var total: u32 = 0;
    while (i.next()) |l| {
        // var first: ?u8 = null;
        // var last: ?u8 = null;
        print("slice {s}\n", .{l});
        var storage: [2]?u8 = std.mem.zeroes([2]?u8);
        for (l) |c| {
            if (c < '0' or c > '9') {
                continue;
            }
            if (storage[0] == null) {
                storage[0] = c;
            }
            storage[1] = c;
        }

        const hello = [2]u8{ storage[0].?, storage[1].? };
        const num: u8 = std.fmt.parseInt(u8, &hello, 10) catch unreachable;
        total += num;
        print("total {d}\n", .{total});
    }

    try expect(total == 55123);
}
