const std = @import("std");

const Cube = struct {
    red: usize = 0,
    green: usize = 0,
    blue: usize = 0,
};

test "solution 2" {
    const file = try std.fs.cwd().openFile("input.txt", .{});
    defer file.close();

    const file_size = try file.getEndPos();
    const allocator = std.heap.page_allocator;
    const file_buffer = try allocator.alloc(u8, file_size);
    defer allocator.free(file_buffer);

    _ = try file.readAll(file_buffer);

    var i = std.mem.splitAny(u8, file_buffer, "\n");
    var total: usize = 0;

    while (i.next()) |line| {
        var Color = Cube{};
        // use the colon to seperate the string literal
        if (std.mem.indexOf(u8, line, ":")) |value| {
            // value + 2 is to skip the colon and a space
            var sets = std.mem.tokenizeSequence(u8, line[value + 2 ..], "; ");

            while (sets.next()) |s| {
                var colors = std.mem.tokenizeSequence(u8, s, ", ");
                while (colors.next()) |c| {
                    var data = std.mem.tokenizeAny(u8, c, " ");
                    const count = try std.fmt.parseInt(usize, data.next().?, 10);
                    const color = data.next().?;
                    if (std.mem.eql(u8, color, "green")) {
                        Color.green = @max(Color.green, count);
                    }
                    if (std.mem.eql(u8, color, "red")) {
                        Color.red = @max(Color.red, count);
                    }
                    if (std.mem.eql(u8, color, "blue")) {
                        Color.blue = @max(Color.blue, count);
                    }
                }
            }
        }

        total += (Color.red * Color.blue * Color.green);
    }

    std.debug.print("total solution 2 {}\n", .{total});
}

test "solution 1" {
    const file = try std.fs.cwd().openFile("input2.txt", .{});
    defer file.close();

    const file_size = try file.getEndPos();
    const allocator = std.heap.page_allocator;
    const file_buffer = try allocator.alloc(u8, file_size);
    defer allocator.free(file_buffer);

    _ = try file.readAll(file_buffer);

    var i = std.mem.splitAny(u8, file_buffer, "\n");
    var total: u16 = 0;

    while (i.next()) |line| {
        // use the colon to seperate the string literal
        if (std.mem.indexOf(u8, line, ":")) |value| {
            // use index of the colon to get the Game number
            const space_sep = std.mem.indexOf(u8, line[0..value], " ").?;
            const game_no_str = line[space_sep + 1 .. value];
            const game_id = try std.fmt.parseInt(u8, game_no_str, 10);
            // value + 2 is to skip the colon and a space
            var sets = std.mem.tokenizeSequence(u8, line[value + 2 ..], "; ");
            var valid_game: bool = true;

            while (sets.next()) |s| {
                var Color = Cube{};
                var colors = std.mem.tokenizeSequence(u8, s, ", ");
                while (colors.next()) |c| {
                    var data = std.mem.tokenizeAny(u8, c, " ");
                    const count = try std.fmt.parseInt(usize, data.next().?, 10);
                    const color = data.next().?;
                    if (std.mem.eql(u8, color, "green")) Color.green = count;
                    if (std.mem.eql(u8, color, "red")) Color.red = count;
                    if (std.mem.eql(u8, color, "blue")) Color.blue = count;
                }
                if (Color.red > 12 or Color.green > 13 or Color.blue > 14) {
                    valid_game = false;
                    break;
                }
            }

            if (valid_game) {
                total += game_id;
            }
        }
    }

    std.debug.print("total solution 1 {}\n", .{total});
}
