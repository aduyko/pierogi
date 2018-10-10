package routes
import (
  "encoding/json"
)

type routeConfig struct {
  Path string `json: path`
  Plugin string `json: plugin`
  Handlers map[string]interface{} `json: handlers`
}

func NewRoute(data []byte) (routeConfig, error) {
  r := routeConfig{}
  err := json.Unmarshal(data, &r)
  return r, err
}
