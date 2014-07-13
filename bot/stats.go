package tetra

import (
	"time"
)

// Continuously reports the network statistics. Should be run in a
// gorotutine.
func (t *Tetra) GetNetworkStats() {
	for {
		num := int64(len(t.Clients.ByNick))

		if num == 0 {
			wait()
		}

		t.Clients.Gauge.Update(num)

		t.Log.Printf("%d clients connected", num)

		wait()
	}
}

func wait() {
	time.Sleep(time.Minute * 1)
}

