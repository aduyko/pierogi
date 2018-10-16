require "roda"
require "open3"
require "json"
require_relative "config/environment.rb"
require_relative "lib/github/github_request_handler.rb"

class Pierogi < Roda
  plugin :slash_path_empty
  plugin :json_parser

  # TODO: Make handlers specific to routes
  route_file = File.read(ROUTE_DATA_FILE)
  data = JSON.parse(route_file)
  handler = GithubRequestHandler.new(data)
  # Something like:
  # handlers = Hash.new
  # data.each do |route_map, plugin_map|
  #  klass = getKlass(route_map["plugin"])
  #  handlers[route_map["path"]] = klass.new(route_map["data"])

  # Generate these based on handlers/routes above ^
  route do |r|
    r.is "github" do
      r.post do
        # r.params is a map, json is parsed automatically by the json_parser plugin
        # if our request is content type application/json
        err = handler.handle_request(r.params)

        # TODO: Should be json responses (status: ok) or whatever
        if err.nil?
          "Script executed!"
        else
          response.status = 400
          "Error: #{err}"
        end
      end
    end
  end
end

