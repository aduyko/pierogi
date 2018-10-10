require "roda"

class Pierogi < Roda
  plugin :slash_path_empty
  plugin :json_parser

  route do |r|
    r.is "github" do
      r.post do
        # r.params is a map, json is parsed automatically by the json_parser plugin
        # if our request is content type application/json
        handle_request(r.params)
      end
    end

    r.on "test" do
      r.is "foo" do
        r.get do
          output = `/Users/andriyduyko/ruby/pierogi/foo.sh`
          success = $?.success?
          puts "script returned '#{output}'"
          puts "script success`: #{success}"
          "script returned #{output}"
        end
      end

      r.post do
        "Goodbye World\n"
      end
    end
  end
end

def handle_request(params)
  params.each do |key, value|
    puts "key #{key}"
    puts "value #{value}"
  end
  "Hello"
end
