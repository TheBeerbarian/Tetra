package tetra

import (
	"strings"

	"github.com/rcrowley/go-metrics"
)

// Struct Clients defines the set of clients on the network, indexed by either
// nickname (in capital letters) or UID.
type Clients struct {
	ByNick map[string]*Client
	ByUID  map[string]*Client
	Gauge  metrics.Gauge
	Tetra  *Tetra
}

// AddClient adds a Client to the Clients structure.
func (c *Clients) AddClient(client *Client) {
	c.ByNick[strings.ToUpper(client.Nick)] = client
	c.ByUID[client.Uid] = client
}

// DelClient deletes a Client from the Clients structure.
func (c *Clients) DelClient(client *Client) (err error) {
	delete(c.ByNick, client.Nick)
	delete(c.ByUID, client.Uid)

	return
}

// ChangeNick changes a client's nickname and updates the ByNick map.
func (c *Clients) ChangeNick(client *Client, newnick string) (err error) {
	if _, present := c.ByNick[strings.ToUpper(client.Nick)]; !present {
		c.Tetra.Log.Fatalf("Client %s does not exist in Clients.ByNick. We are desynched. Exiting.", client.Nick)
	}

	delete(c.ByNick, client.Nick)

	c.ByNick[strings.ToUpper(newnick)] = client

	return
}
