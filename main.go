package main

import (
  "encoding/json"
  "fmt"
  "github.com/go-chi/chi"
  "io/ioutil"
  "net/http"
  "os/exec"
)

// TODO: Update this to use github webhook push structure
type Test struct {
  Hello string `json: hello`
}

func main() {
  r := chi.NewRouter()
  r.Get("/", func(w http.ResponseWriter, r *http.Request) {
    // TODO: Move exec logic into post/githook handling
    {
      cmd := exec.Command("/Users/andriyduyko/go/src/github.com/aduyko/pierogi/cool.sh")
      err := cmd.Run()
      if err != nil {
        panic(err)
      }
    }
  })
  r.Post("/", handleWebhook)
  http.ListenAndServe(":3000", r)
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
