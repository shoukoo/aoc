const print = @import("std").debug.print;
const split = @import("std").mem.splitAny;
const expect = @import("std").testing.expect;
const std = @import("std");
const fs = @import("std").fs;

test "solution 1" {
    const file = try fs.cwd().openFile("input.txt", .{});
    defer file.close();

    // getEndPod returns file size
    // https://ziglang.org/documentation/master/std/src/std/fs/File.zig.html#L283
    const file_size = try file.getEndPos();
    const allocator = std.heap.page_allocator;
    const file_buffer = try allocator.alloc(u8, file_size);
    defer allocator.free(file_buffer);

    _ = try file.readAll(file_buffer);

    var i = split(u8, file_buffer, "\n");

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

        if (storage[0] != null and storage[1] != null) {
            const num_string = [2]u8{ storage[0].?, storage[1].? };
            const num: u8 = std.fmt.parseInt(u8, &num_string, 10) catch unreachable;
            total += num;
        }
    }
    print("total {d}\n", .{total});
}

test "solution 2" {
    const file = try fs.cwd().openFile("input.txt", .{});
    defer file.close();

    // getEndPod returns file size
    // https://ziglang.org/documentation/master/std/src/std/fs/File.zig.html#L283
    const file_size = try file.getEndPos();
    const allocator = std.heap.page_allocator;
    const file_buffer = try allocator.alloc(u8, file_size);
    defer allocator.free(file_buffer);

    _ = try file.readAll(file_buffer);

    var i = split(u8, file_buffer, "\n");

    var total: u32 = 0;
    const nums = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };
    const num_values = [_]u8{ '1', '2', '3', '4', '5', '6', '7', '8', '9' };

    while (i.next()) |l| {
        print("line {s}\n", .{l});

        // Initialise the array with empty values. In this case, the null values are being used to initialise the ?u8 type
        var storage: [2]?u8 = std.mem.zeroes([2]?u8);
        for (l, 0..) |char, index| {
            var matched: ?u8 = null;
            if (char >= '0' and char <= '9') {
                matched = char;
            } else {
                for (nums, 0..) |num, d| {
                    if (std.mem.startsWith(u8, l[index..], num)) {
                        matched = num_values[d];
                        break;
                    }
                }
            }

            if (matched != null) {
                print("matched {c}\n", .{matched.?});
                if (storage[0] == null) {
                    storage[0] = matched;
                }
                storage[1] = matched;
            }
        }

        if (storage[0] != null and storage[1] != null) {
            const num_string = [2]u8{ storage[0].?, storage[1].? };
            const num: u8 = std.fmt.parseInt(u8, &num_string, 10) catch unreachable;
            total += num;
        }
    }
    print("total solution2  {d}\n", .{total});
}
