package webhook

type webhook interface {
  data map
  handle() error
  parse() string
}
