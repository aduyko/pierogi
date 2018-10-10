package main

import (
  "encoding/json"
  "fmt"
  "github.com/go-chi/chi"
  "io/ioutil"
  "net/http"
  "os/exec"

  //"github.com/aduyko/pierogi/internal"
)

func main() {
  r := chi.NewRouter()

  routes, err := readRoutes()
  fmt.Println(routes)
  fmt.Println(err)

  // Read in config files
  // Set up routes based on those configs
  {
    // r.Post("/", githubHandler) 
  }

  {
    r.Get("/", execTestScript)
    r.Get("/test_read", readJSON)
    r.Post("/", handleWebhook)
  }

  http.ListenAndServe(":3000", r)
}



func readRoutes() (map[string]interface{}, error) {
  {
    content, err := ioutil.ReadFile("configs/routes.json")

    // parse json into arbitrary map
    var routeConfig map[string]interface{}
    err = json.Unmarshal(content, &routeConfig)

		for key, val := range routeConfig {
			fmt.Println(key, val)
		}

/*
		if rec, ok := routeConfig["routes"].([]interface{}); ok {
        for _, val := range rec {
            fmt.Printf(" [========>] %s", val)
        }
    } else {
        fmt.Printf("record not a map[string]interface{}: %v\n", routeConfig)
    }

    m := routeConfig["routes"].(map[string]interface{})

    fmt.Println(routeConfig["routes"])
    fmt.Println(m)
    for _, element := range routeConfig["routes"] {
      r,err := routes.NewRoute(element)
      fmt.Println(r)
    }
*/

    return routeConfig, err
  }
}

// TODO: Delete this test function
func execTestScript(w http.ResponseWriter, r *http.Request) {
  {
    cmd := exec.Command("/Users/andriyduyko/go/src/github.com/aduyko/pierogi/cool.sh")
    err := cmd.Run()
    if err != nil {
      panic(err)
    }
  }
}

func readJSON(w http.ResponseWriter, r *http.Request) {
  // read routes.json
  {
    content, err := ioutil.ReadFile("configs/routes.json")
    if err != nil {
      panic(err)
    }

    // parse json into arbitrary map
    var data map[string]interface{}
    err = json.Unmarshal(content, &data)
    if err != nil {
      panic(err)
    }

    fmt.Println(data["/"])
    fmt.Println(data)
  }
}

/*
func handleWebhook(w *Webhook) {
  w.handle();
}
*/
type Test struct {
  Hello string `json: hello`
}
func handleWebhook(w http.ResponseWriter, r *http.Request) {
    body, err := ioutil.ReadAll(r.Body)
    // TODO: Figure out error handling??
    if err != nil {
      panic(err)
    }
    fmt.Println(string(body))

    test := Test{}
    err = json.Unmarshal(body, &test)
    if err != nil {
      panic(err)
    }

    data, err := json.Marshal(test)
    if err != nil {
      panic(err)
    }

    w.Header().Set("Content-Type", "application/json")
    w.Write(data)
}
