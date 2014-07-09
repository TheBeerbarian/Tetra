package tetra

import (
	"errors"
	"strings"
)

type ChanUser struct {
	Client  *Client
	Channel *Channel
	Prefix  int
}

// Implements Targeter
type Channel struct {
	Name    string
	Ts      int64
	Modes   int
	Clients map[string]*ChanUser
	Lists   map[string][]string
}

func (tetra *Tetra) NewChannel(name string, ts int64) (c *Channel) {
	c = &Channel{
		Name:    name,
		Ts:      ts,
		Lists:   make(map[string][]string),
		Clients: make(map[string]*ChanUser),
		Modes:   0,
	}

	tetra.Channels[strings.ToUpper(name)] = c

	return
}

func (c *Channel) AddChanUser(client Client) (cu *ChanUser) {
	cu.Client = &client
	cu.Channel = c
	cu.Prefix = 0

	c.Clients[client.Uid] = cu

	return
}

func (c *Channel) DelChanUser(client Client) (err error) {
	if _, ok := c.Clients[client.Uid]; !ok {
		return errors.New("Tried to delete nonexistent chanuser with uid " + client.Uid + " from " + c.Name)
	}

	delete(c.Clients, client.Uid)

	return nil
}

func (c *Channel) Target() (string) {
	return c.Name
}
