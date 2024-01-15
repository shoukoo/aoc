package main

import (
	"fmt"
	"log/slog"
	"os"
	"strconv"
	"strings"
)

type Cube struct {
	red   int64
	blue  int64
	green int64
}

func main() {
	err := solution1()
	if err != nil {
		slog.Error("solution 1", err)
	}

}

func solution1() error {
	b, err := os.ReadFile("input.txt")
	if err != nil {
		return err
	}

	strs := strings.Split(string(b), "\n")
	var total int64

	for _, v := range strs {

		if v == "" {
			continue
		}

		data := strings.Split(v, ":")

		gameId, err := strconv.ParseInt(strings.Split(data[0], " ")[1], 10, 8)
		if err != nil {
			return err
		}

		sets := strings.Split(data[1], ";")
		validGame := true
		var cube = Cube{}

		for _, s := range sets {
			colorInfo := strings.Split(s, ",")
			for _, color := range colorInfo {
				info := strings.Split(strings.Trim(color, " "), " ")
				count, err := strconv.ParseInt(info[0], 10, 8)
				if err != nil {
					return err
				}
				name := info[1]

				switch name {
				case "red":
					cube.red = count
				case "green":
					cube.green = count
				case "blue":
					cube.blue = count
				}

			}

			if cube.red > 12 || cube.green > 13 || cube.blue > 14 {
				validGame = false
				break
			}

		}

		if validGame {
			total += gameId
		}

	}

	fmt.Printf("total solution 1 %v", total)

	return nil
}
