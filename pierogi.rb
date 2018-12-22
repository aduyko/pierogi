require "roda"
require "json"
require_relative "config/config.rb"
require_relative "lib/github_request_handler.rb"

class Pierogi < Roda
  plugin :slash_path_empty
  plugin :json_parser

  route_file = File.read(ROUTES_FILE)
  routes = JSON.parse(route_file)
  # Initialize handler classes based on route configuration
  handlers = Hash.new
  routes.each do |route, config|
    if config["handler"].nil?
      raise "No handler defined for route #{route}"
    end
    if config["handler_config"].nil?
      raise "No handler configuration defined for route #{route}"
    end
    class_name = "#{config["handler"].capitalize}RequestHandler"
    klass = Object.const_get(class_name)
    handlers[route] = klass.new(config["handler_config"])
  end

  route do |r|
    handlers.each do |path, handler|
      r.is path do
        r.post do
          # r.params is a map, json is parsed automatically by the json_parser plugin
          # if our request is content type application/json
          err = handler.handle_request(r.params)

          # TODO: Should be json responses (status: ok) or whatever
          if err.nil?
            "Request Handled!"
          else
            response.status = 400
            "Error: #{err}"
          end
        end
      end
    end
    # yield a r.is block for 404s because there were no matching paths in the above loop
    r.is "404" do
    end
  end
end

