const std = @import("std");

const Cube = struct {
    red: usize = 0,
    green: usize = 0,
    blue: usize = 0,
};

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
        // use the colon to seperate the string literal
        if (std.mem.indexOf(u8, line, ":")) |value| {
            // use index of the colon to get the Game number
            const space_sep = std.mem.indexOf(u8, line[0..value], " ").?;
            const game_no_str = line[space_sep + 1 .. value];
            const game_no = try std.fmt.parseInt(u8, game_no_str, 2);
            std.debug.print("Game {d}\n", .{game_no});
            // value + 2 is to skip the colon and a space
            std.debug.print("{s:*^100}\n", .{line[value + 2 ..]});
            var token = std.mem.tokenizeSequence(u8, line[value + 2 ..], "; ");

            while (token.next()) |t| {
                std.debug.print("{s}\n", .{t});
            }

            break;
        }
    }
}
