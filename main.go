package main

import (
  "encoding/json"
  "fmt"
  "github.com/go-chi/chi"
  "io/ioutil"
  "net/http"
  "os/exec"
)

func main() {
  r := chi.NewRouter()

  // Read in config files
  // Set up routes based on those configs
  {
    // r.Post
  }

  {
    r.Get("/", execTestScript)
    r.Get("/test_read", readJSON)
    r.Post("/", handleWebhook)
  }

  http.ListenAndServe(":3000", r)
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
