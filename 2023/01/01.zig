const print = @import("std").debug.print;
const split = @import("std").mem.splitAny;
const expect = @import("std").testing.expect;
const input = @import("input.zig");
const std = @import("std");

test "solution 1" {
    var i = split(u8, input.puzzle_input, "\n");
    var total: u32 = 0;
    while (i.next()) |l| {
        // Initialise the array with empty values. In this case, the null values are being used to initialise the ?u8 type
        var storage: [2]?u8 = std.mem.zeroes([2]?u8);
        for (l) |char| {
            // if the character is outside of 0 - 9 range then skip
            if (char < '0' or char > '9') {
                continue;
            }
            if (storage[0] == null) {
                storage[0] = char;
            }
            storage[1] = char;
        }

        const num_string = [2]u8{ storage[0].?, storage[1].? };
        const num: u8 = std.fmt.parseInt(u8, &num_string, 10) catch unreachable;
        total += num;
    }

    try expect(total == 55123);
}
