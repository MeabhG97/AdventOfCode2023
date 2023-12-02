const std = @import("std");

pub fn main() !void {
    var total: i32 = 0;
    var left: i32 = -1;
    var right: i32 = -1;

    var file = try std.fs.cwd().openFile("../../input.txt", .{});
    defer file.close();

    var bufReader = std.io.bufferedReader(file.reader());
    var inStream = bufReader.reader();

    var buf: [1024]u8 = undefined;
    while (try inStream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        for (line) |c| {
            if (c > 0x29 and c < 0x40) {
                if (left != -1) {
                    right = c - 0x30;
                } else {
                    left = c - 0x30;
                    right = c - 0x30;
                }
            }
        }
        total += left * 10 + right;
        left = -1;
    }

    std.debug.print("{}\n", .{total});
}
