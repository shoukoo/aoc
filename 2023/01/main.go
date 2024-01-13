package main

import (
	"fmt"
	"log/slog"
	"os"
	"strconv"
	"strings"
)

func main() {
	total, err := solution1()
	if err != nil {
		slog.Error("error", "content", err)
	}

	slog.Info("solution1", "total", total)

	total2, err := solution2()
	if err != nil {
		slog.Error("error", "content", err)
	}

	slog.Info("solution2", "total", total2)
}

func solution1() (int64, error) {
	b, err := os.ReadFile("input.txt")
	if err != nil {
		return 0, nil
	}

	lines := strings.Split(string(b), "\n")
	var total int64

	for _, line := range lines {
		var s [2]rune
		for _, char := range line {
			var matched rune

			if char >= '0' && char <= '9' {
				matched = char
			}

			if matched != 0 {
				if s[0] == 0 {
					s[0] = matched
				}

				s[1] = matched
			}

		}

		if len(s) == 2 && line != "" {
			numStr := fmt.Sprintf("%c%c", s[0], s[1])
			i, err := strconv.ParseInt(numStr, 10, 64)
			if err != nil {
				return 0, err
			}
			total += i
		}

	}

	return total, nil

}

func solution2() (int64, error) {
	b, err := os.ReadFile("input2.txt")
	if err != nil {
		return 0, nil
	}

	digits := map[string]rune{
		"one":   '1',
		"two":   '2',
		"three": '3',
		"four":  '4',
		"five":  '5',
		"six":   '6',
		"seven": '7',
		"eight": '8',
		"nine":  '9',
	}

	lines := strings.Split(string(b), "\n")
	var total int64

	for _, line := range lines {
		var s [2]rune
		for index, char := range line {
			var matched rune

			if char >= '0' && char <= '9' {
				matched = char
			} else {
				str := line[index:]
				for k, v := range digits {
					if strings.HasPrefix(str, k) {
						matched = v
						break
					}
				}
			}

			if matched != 0 {
				if s[0] == 0 {
					s[0] = matched
				}

				s[1] = matched
			}

		}

		if len(s) == 2 && line != "" {
			numStr := fmt.Sprintf("%c%c", s[0], s[1])
			i, err := strconv.ParseInt(numStr, 10, 64)
			if err != nil {
				return 0, err
			}
			total += i
		}

	}

	return total, nil

}
