// +build debug

package tetra

import "log"

func init() {
	log.SetPrefix("DEBUG ")
}

func debug(args ...interface{}) {
	log.Print(args...)
}

func debugf(format string, args ...interface{}) {
	log.Printf(format, args...)
}
